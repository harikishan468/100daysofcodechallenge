provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAT5JUOVB26FN2UXPJ"
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

resource "aws_instance" "myec2" {
  ami= "ami-08f3d892de259504d"
  instance_type = "t2.micro"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id    = aws_instance.myec2.id
  allocation_id  = aws_eip.lb.id
}