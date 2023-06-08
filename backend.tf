terraform {
  backend "s3" {
    bucket = "ji-terraform-backend"
    key    = "terraform1/terraform.tfstate"
    region = "ap-northeast-2"
    encrypt = true
  }
}
