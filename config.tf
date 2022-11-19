provider "aws" {
  region     = "us-east-1"
}
## Create VPC ##
resource "aws_vpc" "terraform-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "terraform-vpc"
  }
}

output "aws_vpc_id" {
  value = aws_vpc.terraform-vpc.id
}

## Security Group##
resource "aws_security_group" "task-sg" {
  description = "Allow limited inbound external traffic"
  vpc_id      = aws_vpc.terraform-vpc.id
  name        = "task-sg"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "task-sg"
  }
}

output "aws_security_gr_id" {
  value = aws_security_group.task-sg.id
}

## Create Subnets ##
resource "aws_subnet" "terraform_subnet" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = "10.0.0.0/24"
  map_public_ip_on_launch  = "true"
  availability_zone  = "us-east-1a"
  
  tags = {
    Name = "terraform_subnet"
  }
}

output "aws_subnet_subnet" {
  value = aws_subnet.terraform_subnet.id
}


resource "aws_instance" "jenkins-node" {
  ami                         = "ami-0b0dcb5067f052a63"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.task-sg.id}"]
  subnet_id                   = aws_subnet.terraform_subnet.id
  key_name                    = "task-1"
  count                       = 1
  associate_public_ip_address = true
  tags = {
    Name        = "jenkins-node"
  }
}
resource "aws_instance" "deploy-node" {
  ami                         = "ami-0b0dcb5067f052a63"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.task-sg.id}"]
  subnet_id                   = aws_subnet.terraform_subnet.id
  key_name                    = "task-1"
  count                       = 1
  associate_public_ip_address = true
  tags = {
    Name        = "deploy-node"
  }
}
