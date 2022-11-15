provider "aws" {
  region ="us-east-1"
}
resource "aws_vpc" "custom-vpc-tf" {
  cidr_block ="190.160.0.0/16"
  instance_tenancy ="default"

  tags = {
    Name = "custom-vpc-tf"
  } 
}

resource "aws_subnet" "custom-subnet-tf" {
    vpc_id = "${aws_vpc.custom-vpc-tf.id}"
    cidr_block = "190.160.1.0/24"

    tags = {
        Name = "custom-subnet-tf"
    }
}
resource "aws_security_group" "security-tf" {
  name        = "security-tf"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.custom-vpc-tf.id

  ingress {
    description      = "allow all traffic"
    from_port        = all
    to_port          = all
    protocol         = "all"
    cidr_blocks      = [aws_vpc.custom-vpc-tf.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "all"
  }

  tags = {
    Name = "custom-group-tf"
  }
}
resource "aws_instance" "instance-tf" {
  ami = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  availability_zone = "us-east-1"
  vpc_id     = "${aws_vpc.custom-vpc-tf.id}"
  subnet_id = "${aws_subnet.custom-subnet-tf.id"
  security_grpoup_id = "${aws_security_group.security.tf.id}"
  key_name = "my_key"
  tags = {
    Name ="ec2-tf"
  }
}
