output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(module.vpc.aws_vpc.this[0].id, null)
}
