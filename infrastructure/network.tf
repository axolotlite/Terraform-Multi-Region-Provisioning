module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.basename}-vpc-${var.tags["Env"]}"
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.pv_subnets
  public_subnets  = var.pub_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = var.tags
}
module "vpc_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id = module.vpc.vpc_id

  create_security_group      = true
  security_group_name_prefix = "${var.basename}-vpc-${var.tags["Env"]}-endpoints-"
  security_group_description = "VPC endpoint security group"
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from VPC"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  }
  endpoints = {
    dynamodb = {
      service             = "dynamodb"
      private_dns_enabled = true
      service_type        = "Gateway"
      route_table_ids     = flatten([module.vpc.private_route_table_ids])
      policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
          {
            Effect    = "Allow",
            Principal = "*",
            Action    = "dynamodb:*",
            Resource  = "*",
          },
        ],
      })
      tags = {
        Name        = "${var.basename}-dynamodb-vpc-endpoint-${var.tags["Env"]}"
        Terraform   = var.tags["Terraform"]
        Environment = var.tags["Env"]
      }
    }
  }
}
