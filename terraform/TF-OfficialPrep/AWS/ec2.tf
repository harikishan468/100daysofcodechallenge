#VPC creation

resource "aws_vpc" "tf_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terraform_vpc"
  }
}

# EC2 KEY PAIR creation

resource "aws_key_pair" "ec2key" {
  key_name   = "examplekey"
  public_key = file("~/.ssh/terraform.pub")
}

# EC2 SG creation

resource "aws_security_group" "allow_connect" {
  name        = "allow_ssh_http"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH to VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP to VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_http"
  }
}

#EC2 instance creation 

resource "aws_instance" "myec2" {
  key_name        = aws_key_pair.ec2key.key_name
  ami             = "ami-0761dd91277e34178"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.allow_connect.name]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/terraform")
    host        = self.public_ip
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.myec2.public_ip} > ip_address.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras enable nginx1.12",
      "sudo yum -y install nginx",
      "sudo service nginx start",
      "sudo service nginx status"
    ]
  }
}
