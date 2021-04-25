terraform {
  backend "s3" {
    key            = "secret-message-api.tfstate"
    region         = "us-east-1"
  }
}