Launch a Load Balancer
Deploy an application load balancer (ALB) with two target EC2 instances.

Steps
1 - If you alraedy have the VPC and subnet created then you can use it. Better to choose public subnet so that you can verify
2 - Create 2 ec2 instnace in public subnect and install httpd and expose port 80
3 -  create target group and add both the ec2 instance 
4 - Create load balancer and add the target group
