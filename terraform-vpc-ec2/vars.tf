variable "access_key" {
description = "AWS Access key"
default = "AKIAXOBVO4FVF2FIGR5H"
}

variable "secret_key" {
description = "AWS Secret Key"
default = "3SfMcNEqJxERVa2lFtyvpNX0xnMyumwMNqpY6vRi"
}


variable "region" {
description = "AWS region for hosting our your network"
default = "ap-northeast-1"
}


variable "aws_ami" {
description = "AWS region for hosting our your network"
default = "ami-0d979355d03fa2522"
}


variable "key_name" {
description = "Key name for SSH into EC2"
default = "app-ssh-key"
}
