output "instance_ip" {
    value = aws_instance.web-instance[*].public_ip
  
}

output "lb_dns" {
  value = aws_lb.terraform-lb.dns_name
}