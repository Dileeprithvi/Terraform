variable "access_key" {
description = "AWS Access key"
default = "AKIAVPV5JKOU2TYBIB7T"
}

variable "secret_key" {
description = "AWS Secret Key"
default = "i/7KeZHeSUYxnm2AK8U2N2ZZW1adfUA6+H13hrmT"
}


variable "region" {
description = "AWS region for hosting our your network"
default = "us-east-1"
}

variable "vpc_cidr" {
description = "VPC CIDR Range"
default = "10.0.0.0/26"
}


variable "azs" {
description = "Defining the LIST of the azs"
type = "list"
default = ["us-east-1a","us-east-1b","us-east-1c"]
}


variable "subnet_cidr" {
description = "Defining the LIST of the subnet_cidr"
type = "list"
default = ["10.0.0.0/28","10.0.0.16/28","10.0.0.32/28"]
}










