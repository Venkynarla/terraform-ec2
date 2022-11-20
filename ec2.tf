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
