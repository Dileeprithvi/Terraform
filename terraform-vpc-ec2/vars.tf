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


variable "aws_ami" {
description = "AWS region for hosting our your network"
default = "ami-09d95fab7fff3776c"
}


variable "key_name" {
description = "Key name for SSH into EC2"
default = "awskey1"
}