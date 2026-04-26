#Create the Database in the Glue Catalog
resource "aws_glue_catalog_database" "air_quality_db" {
  name = "air_quality_analytics"
}

#Glue Crawler
#A simple Glue Crawler to scan our raw S3 bucket and create the table schema
resource "aws_glue_crawler" "raw_crawler" {
  database_name = aws_glue_catalog_database.air_quality_db.name
  name          = "air_quality_raw_crawler"
  role          = aws_iam_role.glue_role.arn

  s3_target {
    path = "s3://${aws_s3_bucket.raw_data.bucket}/raw/"
  }
}


