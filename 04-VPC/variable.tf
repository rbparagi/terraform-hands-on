variable "cidr_block" {
  description = "The CIDR block for the VPC"
  default = "11.0.0.0/16"
  
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  default = "11.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  default = "11.0.2.0/24"
}

variable "lb1-public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  default = "11.0.3.0/24"
}

variable "lb2-public_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  default = "11.0.4.0/24"
}