# Terraform Infrastructure

This directory is laid out into modules that setup critical infrastructure.

1. `01-vpc` setups the networking details
2. `02-ecr` setups the ECR registry where the docker image will be uploaded
3. `03-app-db` creates the RDS and beanstalk applications with additional resources

After running terraform apply in `01-vpc` and `02-ecr`, you need to upload the
docker image to the ECR repo created in `02-ecr` module. After which you can proceed
to `03-app-db`. Here you need to set the secret message when running the terraform
apply command like so: `terraform apply -var="secret_message='xxxxx'"`
