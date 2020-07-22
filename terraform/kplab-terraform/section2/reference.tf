/*
provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAT5JUOVB2QLEAFYI7"
  secret_key = "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"
}

resource "aws_instance" "myec2" {
  ami= "ami-08f3d892de259504d"
  instance_type = "t2.micro"
}
l
resource "aws_eip" "lb" {
  vpc           = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id    = aws_instance.myec2.id
  allocation_id  = aws_eip.lb.id
}
*/