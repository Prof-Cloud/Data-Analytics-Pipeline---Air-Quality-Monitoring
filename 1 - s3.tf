#S3 Bucket for Raw Sensor Data
resource "aws_s3_bucket" "raw_data" {
  bucket = var.bucket_name_1

  #Allow terraform to delete the bucket even if files exist in the bucket
  force_destroy = true
}

#S3 Bucket Access 
resource "aws_s3_bucket_public_access_block" "S3_access" {
  bucket                  = aws_s3_bucket.raw_data.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle rule 
# Move data to Glacier after 30 days
resource "aws_s3_bucket_lifecycle_configuration" "raw_retention" {
  bucket = aws_s3_bucket.raw_data.id

  rule {
    id     = "archive_old_data"
    status = "Enabled"

    transition {
      days          = 93
      storage_class = "GLACIER"
    }
  }
}
#S3 Bucket for transformed data for Athena queries
resource "aws_s3_bucket" "curated_zone" {
  bucket = var.bucket_name_2

  #Allow terraform to delete the bucket even if files exist in the bucket
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "S3_access_2" {
  bucket                  = aws_s3_bucket.curated_zone.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}