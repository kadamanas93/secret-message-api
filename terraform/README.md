# Module to deploy secret-message API app

This terraform code creates a VPC with private and public subnet for hosting an Elastic Beanstalk
application and RDS.

## Prerequisites

### Tools

1. Terraform (>= 0.15)
2. AWS CLI

### Setup

1. Create s3 bucket to store terraform state
2. Create a secret in AWS Secrets Manager with the secret message

## Usage

1. Terraform init
