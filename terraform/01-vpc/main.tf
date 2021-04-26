locals {
  tags = {
    Environment = "dev"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.78.0"

  name = "api"

  cidr = "10.0.0.0/16"

  azs              = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]

  enable_nat_gateway = false
  single_nat_gateway = true

  enable_s3_endpoint       = true
  enable_dynamodb_endpoint = true

  create_database_subnet_group = true

  tags = local.tags

  vpc_tags = {
    Name = "api-dev"
  }
}