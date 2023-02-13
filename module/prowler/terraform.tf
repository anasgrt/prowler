terraform {
  required_version = "~> 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.53.0"
    }
  }

  backend "s3" {
    region         = "eu-west-1"
    bucket         = "kabisa-terraform-statefiles"
    dynamodb_table = "kabisa-terraform-lockfiles"
    key            = "kabisa-playground-anas/v2-vpc-module-standardized.tfstate"
    encrypt        = true
    role_arn       = "arn:aws:iam::003476575487:role/admin"
    session_name   = "terraform"
  }
}



