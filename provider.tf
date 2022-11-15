provider "aws" {
region ="us-east-1"
}
resource "aws_vpc" "vpc_test" {
  cidr_block = "190.160.0.0/16"
  instance_tenancy ="default"
  
  tags ={
    Name="vpc_test"
  }
}
resource "aws_subnet" "subnet_test" {
  vpc_id ="${aws_vpc.vpc_test.id}"
  cidr_block - "190.160.0.0/24"
  availability_zone = "us-east-1"
  
  tags ={
    Name="subnet_test"
  }
}
resource "aws_instance" "terra_test" {
  ami = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.keypair.my_key}"
  vpc_security_group_ids =[aws_security_group.security_test.id]
  
  tags = {
    Name = "terra_test"
  }
}
resource "aws_security_group" "security_test" {
  name = "security_test"
  description = "testing security group for terraform"
  vpc_id = "${aws_vpc.vpc_test.id}"
  ingress{
    description = "http from vpc"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0./0"]
  }
  ingress{
    description = "tomcat port from vpc"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0./0"]
  }
  ingress{
    description = "tls from vpc"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0./0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0./0"]
  }
  tags = {
    Name = "security_test"
  }
  
