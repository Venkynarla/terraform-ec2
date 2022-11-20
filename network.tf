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


resource "aws_internet_gateway" "terra-igw" {
  vpc_id            = aws_vpc.terraform-vpc.id
}

resource "aws_route_table" "terra-pub-rt" {
  vpc_id            = aws_vpc.terraform-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra-igw.id
  }
}

resource "aws_route_table_association" "pub-rt-association" {
  subnet_id = aws_subnet.terraform_subnet.id
  route_table_id = aws_route_table.terra-pub-rt.id
}
