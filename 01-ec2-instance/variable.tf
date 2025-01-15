variable "ami" {    
  description = "The AMI to use for the EC2 instance"
  default = "ami-0219bfb6c89d10de5"
  
}
variable "instance_type" {
  description = "The type of EC2 instance to launch"
  default = "t2.micro"
  
}