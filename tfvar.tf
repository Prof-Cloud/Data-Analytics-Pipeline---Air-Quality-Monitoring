#Bucket name, for Raw Sensor Data
variable "bucket_name_1" {
  default = "air-quality-raw-data-analytics"
}

#Bucket name, for transformed data for Athena queries
variable "bucket_name_2" {
  default = "air-quality-curated-analytics"
}

#The Data Lookup
# This block tells Terraform to go find the name of the region 
# specified in your provider (eu-west-2) and make it available as a variable.
data "aws_region" "current" {}