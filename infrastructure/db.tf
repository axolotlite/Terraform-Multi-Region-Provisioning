#for testing
#module "dynamodb_table" {
#  source   = "terraform-aws-modules/dynamodb-table/aws"
#
#  name     = "my-table"
#  hash_key = "id"
#
#  attributes = [
#    {
#      name = "id"
#      type = "N"
#    }
#  ]
#
#  tags = {
#    Terraform   = "true"
#    Environment = "staging"
#  }
#}
#resource "aws_instance" "example_server" {
#
#  ami = data.aws_ami.amazon_linux.id
#  instance_type = "t2.micro"
#  key_name ="vockey"
#  subnet_id = module.vpc.public_subnets[0]
#  vpc_security_group_ids = [aws_security_group.ssh_sg.id]
#  associate_public_ip_address = "true"
#  tags = {
#
#    Name = "test_dynamo_connectivity"
#
#  }
#
#}

module "dynamodb_table" {
  source                                = "terraform-aws-modules/dynamodb-table/aws"
  name                                  = "${var.basename}-table-${var.tags["Env"]}"
  hash_key                              = "id"
  range_key                             = "title"
  billing_mode                          = "PROVISIONED"
  read_capacity                         = 5
  write_capacity                        = 5
  autoscaling_enabled                   = true
  ignore_changes_global_secondary_index = true

  autoscaling_read = {
    scale_in_cooldown  = 50
    scale_out_cooldown = 40
    target_value       = 45
    max_capacity       = 10
  }

  autoscaling_write = {
    scale_in_cooldown  = 50
    scale_out_cooldown = 40
    target_value       = 45
    max_capacity       = 10
  }

  autoscaling_indexes = {
    TitleIndex = {
      read_max_capacity  = 30
      read_min_capacity  = 10
      write_max_capacity = 30
      write_min_capacity = 10
    }
  }

  attributes = [
    {
      name = "id"
      type = "N"
    },
    {
      name = "title"
      type = "S"
    },
    {
      name = "age"
      type = "N"
    }
  ]

  global_secondary_indexes = [
    {
      name               = "TitleIndex"
      hash_key           = "title"
      range_key          = "age"
      projection_type    = "INCLUDE"
      non_key_attributes = ["id"]
      write_capacity     = 10
      read_capacity      = 10
    }
  ]

  tags = var.tags
}
