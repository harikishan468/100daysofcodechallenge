#1 VPC creation

resource "aws_vpc" "tf_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terraform_vpc"
  }
}

#2 Create a subnet
resource "aws_subnet" "tf-subnet-1" {
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-test-subnet"
  }
}

#3 Create internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.tf_vpc.id
}

#4 Create  Custom Route table

resource "aws_route_table" "tf-route-table" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Prod"
  }
}


#5. Associate Route table 

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.tf-subnet-1.id
  route_table_id = aws_route_table.tf-route-table.id
}



#6 EC2 KEY PAIR creation

resource "aws_key_pair" "ec2key" {
  key_name   = "examplekey"
  public_key = file("~/.ssh/terraform.pub")
}

#7 EC2 SG creation

resource "aws_security_group" "allow_connect" {
  name        = "allow_ssh_http"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.tf_vpc.id

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

/*
#EC2 instance creation 

resource "aws_instance" "myec2" {
  key_name          = aws_key_pair.ec2key.key_name
  ami               = "ami-0761dd91277e34178"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  subnet_id         = aws_subnet.tf-subnet-1.id
  security_groups   = aws_security_group.allow_connect.id


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

*/