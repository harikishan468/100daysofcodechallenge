/*
provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAQNZMG3IIWQ2XY6IE"
  secret_key = "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"
}

resource "aws_eip" "lb" {
  vpc      = true
}

output "eip" {
  value = aws_eip.lb.public_ip
}

resource "aws_s3_bucket" "mys3" {
  bucket = "syler-bucket"
}

output "mys3bucket" {
  value = aws_s3_bucket.mys3.bucket_domain_name
}
*/