# Secret Message API

This application reads environment variable SECRET_MESSAGE and sets up an API endpoint `/secret` that will return the secret message.
It also has an `/health` endpoint for Infra services to verify if the app is healthy.

The source code is in `*.go` files while the infrastructure is setup in `terraform` directory. Make sure to read the README.md
under that directory to correctly setup the application infrastructure.

## Prerequisites

1. Go (> 1.11)
2. Docker

## Configuration

Set these environment variables

1. PORT -> the port the http server will be exposed on (default 8080)
2. SECRET_MESSAGE -> the env var where the secret is stored
3. DB_USERNAME -> username for the SQL server
4. DB_PASSWORD -> password for the above user
5. DB_URL -> endpoint for SQL server

## Future Work

1. Increase test coverage: Test sql connection function
2. Setup versioning for docker images
3. Create automated build and push docker image pipeline
4. Add downstream dependencies health check under `/health` api
5. Force SSL for AWS Beanstalk LB
6. Setup encryption and locking for terraform state files
