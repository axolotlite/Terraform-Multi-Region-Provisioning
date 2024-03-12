variable "vpc_cidr" {
  description = "the cidr of the newly created vpc"
  type        = string
}
variable "azs" {
  description = "the availability zones hosting the ec2 instances"
  type        = list(string)
}
variable "pv_subnets" {
  description = "an array of private subnets within the vpc"
  type        = list(string)
}
variable "pub_subnets" {
  description = "an array of private subnets within the vpc"
  type        = list(string)
}
variable "tags" {
  description = "tags to be put on resources"
  type        = map(string)
  default = {
    Env       = "testing"
    Terraform = "true"
  }
}
variable "basename" {
  description = "then base name of all resources"
  type        = string
  default     = "iti"
}
variable "min_instances" {
  description = "the minimum number of ec2 instances in an az"
  type        = number
  default     = 0
}
variable "max_instances" {
  description = "the maximum number of ec2 instances in an az"
  type        = number
  default     = 1
}
variable "desired_instances" {
  description = "the maximum number of ec2 instances in an az"
  type        = number
  default     = 1
}
variable "ec2_as_sg" {
  description = "the security groups given to the autoscaler for use in the ec2 template networking"
  type        = list(string)
  default     = null
}
