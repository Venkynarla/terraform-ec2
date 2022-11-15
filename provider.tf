provider "aws" {
  region ="us-west-2"
}
resource "aws_vpc" "custom-vpc-tf" {
  cidr_block ="190.160.0.0/16"
  instance_tenancy ="default"

  tags {
    Name = "main"
  } 
}

resource "aws_subnet" "custom-subnet-tf" {
    vpc_id = "${aws_vpc.custom-vpc-tf.id}"
    cidr_block = "190.160.1.0/24"

    tags {
        Name = "custom-subnet-tf"
    }
}
