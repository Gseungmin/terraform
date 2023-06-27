# Create an S3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "ji-sm-test-bucket"

  tags = {
    Name = "My bucket"
  }
}

# Create an S3 bucket policy to deny access to anyone except the OAI
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyAllExceptOAI",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*",
      "Condition": {
        "StringNotEquals": {
          "aws:PrincipalOrgID": "${aws_cloudfront_origin_access_identity.oai.iam_arn}"
        }
      }
    }
  ]
}
POLICY
}
