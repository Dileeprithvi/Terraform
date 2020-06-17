# List of the resources created as mentioned in the tf files

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
