variable "azs" {
  description="the availability zones hosting the ec2 instances"
  type=list(string)
}
variable "pv_subnets"{
  description="an array of private subnets within the vpc"
  type=list(string)
}
variable "pub_subnets"{
  description="an array of private subnets within the vpc"
  type=list(string)
}
