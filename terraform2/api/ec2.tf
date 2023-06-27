#IAM role which EC2 will assume
resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

#IAM policy that allows EC2 instances to interact with DynamoDB
resource "aws_iam_policy" "ec2_dynamodb_policy" {
  name        = "ec2_dynamodb_policy"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

#Attaches the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "test_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_dynamodb_policy.arn
}

#EC2 instance
resource "aws_instance" "ec2_instance" {
  ami           = "ami-0c9c942bd7bf113a2"
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  tags = {
    Name = "MyInstance"
  }
}

#IAM instance profile
resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
  role = aws_iam_role.ec2_role.name
}
