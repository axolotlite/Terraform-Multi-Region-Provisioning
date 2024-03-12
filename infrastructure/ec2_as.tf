module "ec2-autoscaling" {
  source = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name            = "${var.basename}-ec2-autoscaler-${var.tags["Env"]}"
  use_name_prefix = true

  vpc_zone_identifier = module.vpc.public_subnets
  min_size            = var.min_instances
  max_size            = var.max_instances
  desired_capacity    = var.desired_instances

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  tags          = var.tags
  key_name      = "main_key"
  network_interfaces = [
    {
      description                 = "EFA interface example"
      delete_on_termination       = true
      device_index                = 0
      security_groups             = var.ec2_as_sg == null ? [] : var.ec2_as_sg
      associate_public_ip_address = true
    }
  ]

}
