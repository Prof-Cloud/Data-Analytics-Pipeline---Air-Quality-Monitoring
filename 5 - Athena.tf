# Athena Workgroup  
#This is where you actually run your SQL queries
resource "aws_athena_workgroup" "analytics" {
  name = "air_quality_primary"

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = "s3://${aws_s3_bucket.curated_zone.bucket}/athena-results/"
    }
  }
}