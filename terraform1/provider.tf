provider "aws" {
  region = "ap-northeast-2"
}

provider "aws" {
  alias  = "jp"
  region = "ap-northeast-1"
}
