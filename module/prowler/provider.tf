provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::099211283664:role/admin"
  }
}




