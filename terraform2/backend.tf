terraform {
  backend "s3" {
    bucket = "second-backend"
    key    = "terraform2/terraform.tfstate"
    region = "ap-northeast-2"
    encrypt = true
  }
}
