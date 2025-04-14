terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.1"
    }
  }
}

# AWS provider configuration
provider "aws" {
  region  = "us-east-1"
  profile = "Terraform-user"
}


# Create an S3 bucket for storing the Terraform state file
resource "aws_s3_bucket" "terraform_state" {
  bucket = "edwardokotobuckethouse2"

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Development"
  }
}

# Create a DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Lock Table"
    Environment = "Development"
  }
}

# Configure the Terraform backend to use S3 and DynamoDB for state management and locking
terraform {
  backend "s3" {
    bucket         = "edwardokotobuckethouse1"                             # Name of the S3 bucket
    key            = "edwardokotobuckethouse1/terraform/terraform.tfstate" # Path to the Terraform state file
    region         = "us-east-1"                                           # AWS region
    dynamodb_table = "terraform-state-lock"                                # DynamoDB table for state locking
    encrypt        = true
    profile        = "Terraform-user" # Enable server-side encryption

  }
}
