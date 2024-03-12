#data "aws_iam_policy_document" "full_dynamo_access" {
#  resources = [module.dynamodb_table.]
#}
#resource "aws_iam_policy_attachment" "dynamodb_full_access_attachment" {
#  name       = "dynamodb-full-access-attachment"
#  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
#  roles      = ["LabRole"]
#}
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }
}
resource "aws_key_pair" "default" {
  key_name   = "main_key"
  public_key = file("./infrastructure/main.pub")
}
