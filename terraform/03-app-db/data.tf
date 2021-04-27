data "terraform_remote_state" "tfstates" {
  for_each = toset([
    "vpc",
    "ecr",
  ])
  backend = "s3"
  config = {
    bucket = "terraform-s3-backend-mine"
    key    = format("%s.tfstate", each.value)
    region = "us-east-2"
  }
}