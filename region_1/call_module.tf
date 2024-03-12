module "infrastructure_east" {
  source      = "../infrastructure"
  vpc_cidr    = "10.0.0.0/16"
  azs         = ["us-east-1a", "us-east-1b"]
  pv_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  pub_subnets = ["10.0.100.0/24", "10.0.101.0/24"]
  ec2_as_sg   = [aws_security_group.ssh_sg.id]
}

resource "aws_security_group" "ssh_sg" {
  name        = "allow_ssh"
  description = "allows ssh access for debugging"
  vpc_id      = module.infrastructure_east.vpc_id
  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "ALL"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
