# terraform-ec2-user-data

This terrafrom snippet will create the aws ec2 instance along with the User data ( httpd.sh )

After successfully running the "terraform apply" the ec2 instance will be created along with the User data.

When the aws ec2 instance is successfully created and it is running, copy the "Public IP" of the instance present in the AWS Management Console and Paste it in the Web browser and press enter to see the customized HTML Page.


# terraform-vpc-ec2

This terraform snippet will create the list of resources as below.

<img src="https://user-images.githubusercontent.com/34166409/84894637-bbd82180-b0be-11ea-9930-441dd8ab2ae6.png">

* Please refer the Amazon VPC Documentation for understanding the AWS VPC Resources.
https://aws.amazon.com/vpc/

This terraform Snippet will create a
  * VPC
  * Internet Gateway
  * NAT Gateway
  * One Private Subnet associated to Private route table with NAT Gateway
  * One Public Subnet associated to Public route table with Internet Gateway
  * Public Security Group (Allow traffic of ports 80, 22 to outside world)
  * Private Security Group (Allow traffic of port 22 to Public Subnet CIDR)
  * Web EC2 instance with user data launching in Public Subnet
  * Private EC2 instance launching in Private Subnet
