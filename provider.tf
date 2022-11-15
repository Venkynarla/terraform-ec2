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
    from_port        = 0
    to_port          = 0
    protocol         = "all"
    cidr_blocks      = [aws_vpc.custom-vpc-tf.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "all"
  }

  tags = {
    Name = "security-tf"
  }
}
resource "aws_instance" "ec2-tf" {
  ami = "ami-08c40ec9ead489470" #us-east-1
  instance_type = "t2.micro"
  vpc_security_group_ids        = [
        "${aws_security_group.security-tf.id}" ,
        "${aws_vpc.custom-vpc-tf.id}"
    ]
  subnet_id = "${aws_subnet.custom-subnet-tf.id}"
  key_name = "my_key.pem"
  
  tags = {
    Name ="ec2-tf"
  }
}

