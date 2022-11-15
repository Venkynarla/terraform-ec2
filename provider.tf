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
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
     cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security-tf"
  }
}
resource "aws_instance" "ubuntu" {
  ami = "ami-08c40ec9ead489470" #us-east-1
  instance_type = "t2.micro"
  security_groups =["aws_security_group.security.tf.name"]
   key_pair = "my_key"
  
  tags = {
    Name ="test-terra"
  }
}

