terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "bucket-eabrahym"
    key = "tfstate/terraform.tfstate"
    region = "us-east-1"
  }
}

#Configure the AWS Provider.
provider "aws" {
  region = "us-east-1"
}

module "server"{
    source = "./module"
    
    cluster_name = "terra-ec2"
    instance_type = "t2.micro"
    min_size = 1
    max_size = 5
}

