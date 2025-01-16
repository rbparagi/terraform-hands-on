variable "vpc_id" {
  default = "vpc-042b75bf29b4fea1d"
}

variable "subnet_ids" {
  default = ["subnet-02d032bdc5d4251fa", "subnet-0d87453cb0a2193fd"]
}

variable "lb-subnet_ids" {
  default = ["subnet-02148396bdfdc2f17", "subnet-0962db3270c450108"]
}

variable "number_of_instances" {
  default = 2
  
}

variable "region" {
  default = "ap-south-1"
  
}

variable "ami_id" {
  default = "ami-0fd05997b4dff7aac"
  
}

variable "key_pair" {
  default = "ravi-personal-mac"
  
}

variable "enable_public_ip" {
  default = true
  
}

variable "instance_type" {
  default = "t2.micro"
  
}