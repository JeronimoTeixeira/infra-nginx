terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
  skip_credentials_validation = true
  skip_metadata_api_check = true
  endpoints {
    ec2       = "http://localhost:4566"
    s3        = "http://localhost:4566"
    sts       = "http://localhost:4566"
    ecs       = "http://localhost:4566"
    elbv2     = "http://localhost:4566"
    ssm       = "http://localhost:4566"
    ecr       = "http://localhost:4566"
  }
}
