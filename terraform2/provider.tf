provider "aws" {
  region = "ap-northeast-2"
}

module "api" {
  source = "./api"
}

module "s3" {
  source = "./s3"
}

module "sqs" {
  source = "./sqs"
}
