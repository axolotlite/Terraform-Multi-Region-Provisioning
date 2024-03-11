module "ec2-autoscaling" {
  providers = {
    aws = aws.east
  }
  source = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "default-to-be-set"

  vpc_zone_identifier = module.vpc.public_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

}
