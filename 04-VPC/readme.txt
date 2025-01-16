1 - Create a VPC
CIDR Block: 11.0.0.0/16
Enable DNS resolution and hostname support.
Add tags to identify the VPC as "Development-VPC".

2 Add Subnets
Create:
1 public subnet in us-east-1a with CIDR 11.0.1.0/24.
1 private subnet in us-east-1a with CIDR 11.0.2.0/24.

3 - Configure an Internet Gateway (IGW)
Attach the IGW to the VPC.
Add a route to allow internet traffic for the public subnet.

4 - Create Route Tables
Associate:
Public subnet with a route table containing the IGW route.
Private subnet with a route table containing the NAT Gateway route.
