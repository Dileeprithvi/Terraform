#! /bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Terraform Instance Launched Successfully from Public Subnet of Custom VPC!!!!!</h1>" | sudo tee /var/www/html/index.html
