## Create VPC ##
resource "aws_vpc" "${var.vpc_name}" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags = {
    Name = "terraform-vpc"
  }
}

output "aws_vpc_id" {
  value = aws_vpc.terraform-vpc.id
}
## Create Subnets ##
resource "aws_subnet" "${var.subnet_name}" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.subnet_cidr}"
  map_public_ip_on_launch  = "true"
  availability_zone  = "${var.subnet_zone}"
  
  tags = {
    Name = "terraform_subnet"
  }
}

output "aws_subnet_subnet" {
  value = aws_subnet.terraform_subnet.id
}

resource "aws_internet_gateway" "terra-igw" {
  vpc_id            = "${var.vpc_id}"
}

resource "aws_route_table" "terra-pub-rt" {
  vpc_id            = "${var.vpc_id}"
  route {
    cidr_block = "${var.rt_cidr}"
    gateway_id = "${var.igw_id}"
  }
}

resource "aws_route_table_association" "pub-rt-association" {
  subnet_id = "${var.subnet_id}"
  route_table_id = "${var.rt_id}"
}
