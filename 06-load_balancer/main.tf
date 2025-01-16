resource "aws_security_group" "allow_http-sg" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (Consider restricting this for better security)
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  
}

resource "aws_instance" "web-instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_pair
    associate_public_ip_address = var.enable_public_ip
    subnet_id = var.subnet_ids[0]
    #security_groups = [aws_security_group.allow_http-sg.id]
    vpc_security_group_ids = [aws_security_group.allow_http-sg.id]
    count = var.number_of_instances

    user_data = <<-EOF
              #!/bin/bash
              sodo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Welcome to Apache Server - Provisioned by Terraform `hostname`</h1>" > /var/www/html/index.html
              EOF

    tags = {
      "Name" = "AWS-Web-Instance-${count.index + 1}"
      "Environment" = "Developmemt"
    }  
  
}

resource "aws_security_group" "terraform-alb_sg" {
  name        = "terraform-alb-security-group"
  description = "Allow HTTP traffic for ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terrafor - ALB Security Group"
  }
}

resource "aws_lb_target_group" "terraform-alb-tg" {
  name        = "terraform-alb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }

  tags = {
    Name = "Terraform - ALB Target Group"
  }
  
}

resource "aws_alb_target_group_attachment" "terraform-alb-tga" {
  target_group_arn = aws_lb_target_group.terraform-alb-tg.arn
  count            = var.number_of_instances
  target_id        = aws_instance.web-instance[count.index].id
  port             = 80
  
}

#Create an ALB and associate it with the target group.

resource "aws_lb" "terraform-lb" {
  name            = "terraform-ab"
  internal        = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.terraform-alb_sg.id]
  subnets         = var.lb-subnet_ids
  tags = {
    Name = "Terraform - LB"
  }
  
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.terraform-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terraform-alb-tg.arn
  }
}

