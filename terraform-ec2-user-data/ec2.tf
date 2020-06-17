provider "aws" {
        access_key = "${var.access_key}"
        secret_key = "${var.secret_key}"
        region = "${var.region}"
}

resource "aws_instance" "web-instance" {
        ami = "${var.aws_ami}"
        instance_type = "t2.micro"
        key_name = "${var.key_name}"
        user_data = "${file("httpd.sh")}"
        vpc_security_group_ids = ["${aws_security_group.webSG.id}"]
  tags = {
    Name = "web-instance"
  }
}

#Creating the Security Group  
resource "aws_security_group" "webSG" {
  name        = "webSG"
  description = "Allow ssh  inbound traffic"
  vpc_id      = "vpc-f0525289"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    
  }
}
