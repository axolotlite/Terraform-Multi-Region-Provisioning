module "infrastructure_west" {
  source      = "../infrastructure"
  vpc_cidr    = "10.0.0.0/16"
  azs         = ["us-west-2a", "us-west-2b"]
  pv_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  pub_subnets = ["10.0.100.0/24", "10.0.101.0/24"]
}
