module "build_east" {
  providers = {
    aws = aws.east
  }
  source = "./region_1"
}
module "build_west" {
  providers = {
    aws = aws.west
  }
  source = "./region_2"
}

