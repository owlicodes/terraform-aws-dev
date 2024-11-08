resource "aws_vpc" "mtc_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "mtc_public_subnet" {
  vpc_id                  = aws_vpc.mtc_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "dev-public-subnet"
  }
}

resource "aws_internet_gateway" "mtc_internet_gateway" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    Name = "dev-internet-gateway"
  }
}

resource "aws_route_table" "mtc_public_route_table" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    Name = "dev-public-route-table"
  }
}

resource "aws_route" "default_public_route" {
  route_table_id         = aws_route_table.mtc_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mtc_internet_gateway.id
}

resource "aws_route_table_association" "mtc_public_route_association" {
  subnet_id      = aws_subnet.mtc_public_subnet.id
  route_table_id = aws_route_table.mtc_public_route_table.id
}

resource "aws_security_group" "mtc_security_group" {
  name        = "dev-security-group"
  description = "Security group for development environment."
  vpc_id      = aws_vpc.mtc_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "mtckey" {
  key_name   = "mtckey"
  public_key = file("~/.ssh/mtckey.pub")
}

resource "aws_instance" "dev_ec2_instance" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.dev_server_ami.id
  key_name               = aws_key_pair.mtckey.id
  vpc_security_group_ids = [aws_security_group.mtc_security_group.id]
  subnet_id              = aws_subnet.mtc_public_subnet.id

  user_data = file("userdata.tpl")

  tags = {
    Name = "dev-ec2-instance"
  }

  provisioner "local-exec" {
    command = templatefile(var.host_os, {
      hostName     = self.public_ip,
      user         = "ec2-user",
      identityFile = "~/.ssh/mtckey"
    })
    interpreter = ["Powershell", "-Command"]
  }
}

output dev_ec2_instance_public_ip {
  value = aws_instance.dev_ec2_instance.public_ip
}
