locals {
  name = "secret-api"
  tags = {
    Environment = "dev"
  }
}


resource "aws_ecr_repository" "secret_api" {
  name                 = local.name
  image_tag_mutability = "MUTABLE"

  tags = local.tags
}