# Kinesis Firehouse Delivery Stream
#Takes data from IoT and put it into S3
resource "aws_kinesis_firehose_delivery_stream" "ingest_stream" {
  name        = "air-quality-ingestion"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.raw_data.arn

    #Dynamicly keeps the bucket organzed by date
    #This will make it much faster for Athena to find data later
    prefix              = "raw/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/"
    error_output_prefix = "errors/!{firehose:error-output-type}/!{timestamp:yyyy}/"

    #Firehose will wait until it has 5MB of data or 60 secs have passed before writing it to S3
    buffering_size     = 5  # MB
    buffering_interval = 60 # Seconds
  }
}

#Rule
#This tells IoT Core, If you see data on this topic, send it to Firehose
resource "aws_iot_topic_rule" "to_firehose" {
  name        = "RouteToFirehose"
  sql         = "SELECT * FROM 'sensors/air_quality'"
  sql_version = "2016-03-23"
  enabled     = true

  firehose {
    delivery_stream_name = aws_kinesis_firehose_delivery_stream.ingest_stream.name
    role_arn             = aws_iam_role.iot_rule_role.arn
  }
}

