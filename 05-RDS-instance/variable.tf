variable "vpc_id" {
  default = "vpc-042b75bf29b4fea1d"
}

variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-02d032bdc5d4251fa", "subnet-0533a4f71a5e48814"]
}