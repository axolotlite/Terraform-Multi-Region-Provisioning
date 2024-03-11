data "aws_iam_policy_document" "full_dynamo_access" {
  provider = aws.east
  policy_id = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}
data "aws_ami" "amazon_linux" {
  provider = aws.east
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }
}
