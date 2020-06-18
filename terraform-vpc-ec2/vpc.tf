# Defining the Provider of the Terraform

provider "aws" {
        access_key = "${var.access_key}"
        secret_key = "${var.secret_key}"
        region = "${var.region}"
}

# Defining the VPC

resource "aws_vpc" "terraform_vpc" {
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "terraform_vpc"
  }
}

# Defining the VPC Subnets

resource "aws_subnet" "subnets" {
  count = "${length(var.azs)}"
  vpc_id = "${aws_vpc.terraform_vpc.id}"
  cidr_block = "${element(var.subnet_cidr,count.index)}"

  tags = {
    Name = "sub-${count.index+1}"
  }
}








