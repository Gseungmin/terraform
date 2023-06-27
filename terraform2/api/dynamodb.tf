#DynamoDB table
resource "aws_dynamodb_table" "dynamodb_table" {
  name           = "my_table"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "ID"

  attribute {
    name = "ID"
    type = "N"
  }

  tags = {
    Name = "MyTable"
  }
}
