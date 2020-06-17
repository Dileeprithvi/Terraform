# Defining the Provider of the Terraform

provider "aws" {
        access_key = "${var.access_key}"
        secret_key = "${var.secret_key}"
        region = "${var.region}"
}

# Defining the VPC

resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/26"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "terraform_vpc"
  }
}

# Defining the VPC Subnets

resource "aws_subnet" "pub-sub1" {
  cidr_block = "10.0.0.0/28"
  vpc_id = "${aws_vpc.terraform_vpc.id}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-sub-A"
  }
}

/*
resource "aws_subnet" "pub-sub2" {
  cidr_block = "10.0.0.16/28"
  vpc_id = "${aws_vpc.terraform_vpc.id}"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-sub-B"
  }
}

resource "aws_subnet" "pri-sub1" {
  cidr_block = "10.0.0.32/28"
  vpc_id = "${aws_vpc.terraform_vpc.id}"
  availability_zone = "us-east-1c"

  tags = {
    Name = "pri-sub-A"
  }
}

*/

resource "aws_subnet" "pri-sub2" {
  cidr_block = "10.0.0.48/28"
  vpc_id = "${aws_vpc.terraform_vpc.id}"
  availability_zone = "us-east-1d"

  tags = {
    Name = "pri-sub-B"
  }
}

# Defining the VPC Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.terraform_vpc.id}"

  tags = {
    Name = "terraform_vpc_igw"
  }
}

# Defining the Elastic IP Address for NAT

resource "aws_eip" "nat" {
vpc      = true
}

# Defining the VPC NAT Gateway

resource "aws_nat_gateway" "terraform_vpc_nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.pub-sub1.id}"
  depends_on = ["aws_internet_gateway.igw"]
  tags = {
    Name = "terraform_vpc_nat"
  }
}



# Defining the route table for public subnet

resource "aws_route_table" "pub-route" {
  vpc_id = "${aws_vpc.terraform_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "Public_Route"
  }
}

# Associating the Public subnet to the Internet exposed route table

resource "aws_route_table_association" "aws_rt_association" {
  route_table_id = "${aws_route_table.pub-route.id}"
  subnet_id = "${aws_subnet.pub-sub1.id}"
}

# Defining the route table for private subnet

resource "aws_route_table" "pri-route" {
  vpc_id = "${aws_vpc.terraform_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.terraform_vpc_nat.id}"
  }

  tags = {
    Name = "Private_Route"
  }
}

# Associating the Private subnet to the NAT exposed route table

resource "aws_route_table_association" "aws_rt_association2" {
  route_table_id = "${aws_route_table.pri-route.id}"
  subnet_id = "${aws_subnet.pri-sub2.id}"
}



# Defining the Public Subnet Security Group

resource "aws_security_group" "sg_public" {
  name = "sg_public"
  description = "Allowing Internet Access"
  vpc_id = "${aws_vpc.terraform_vpc.id}"

  tags = {
    Name = "sg_public_subnet"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}

# Defining the Private Subnet Security Group

resource "aws_security_group" "sg_private" {
  name = "sg_private"
  description = "Restricted Access"
  vpc_id = "${aws_vpc.terraform_vpc.id}"

  tags = {
    Name = "sg_private_subnet"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      aws_subnet.pub-sub1.cidr_block]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

# Creating the aws ec2 instance in the Public Subnet


resource "aws_instance" "web-instance" {
        ami = "${var.aws_ami}"
		subnet_id = "${aws_subnet.pub-sub1.id}"
        instance_type = "t2.micro"
        key_name = "${var.key_name}"
        user_data = "${file("httpd.sh")}"
        vpc_security_group_ids = ["${aws_security_group.sg_public.id}"]
  tags = {
    Name = "web-instance"
  }
}

# Creating the aws ec2 instance in the Private Subnet with SSH accessible from Public Subnet CIDR

resource "aws_instance" "private-instance" {
        ami = "${var.aws_ami}"
		subnet_id = "${aws_subnet.pri-sub2.id}"
        instance_type = "t2.micro"
        key_name = "${var.key_name}"
        vpc_security_group_ids = ["${aws_security_group.sg_private.id}"]
  tags = {
    Name = "private-instance"
  }
}







