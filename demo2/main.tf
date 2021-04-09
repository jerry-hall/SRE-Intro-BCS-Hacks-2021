provider "aws" {
  region = "us-east-1"

  assume_role {
    # Note: This role is already set up in my AWS account; I am merely assuming 
    #       this role (meaning, I am granted all its permissions)
    role_arn = "arn:aws:iam::${var.account_id}:role/tf-automation-user-role"        
  }
}

terraform {
  backend "local" {
    # For the purposes of this demo, I'm storing the Terraform state locally.
    # It is HIGHLY recommended in organizations to store state in the cloud,
    # i.e. in S3 or GCS
    path = "./terraform.tfstate"    
  }
}

variable "account_id" {
  description = "Variable containing your AWS account ID"
}