# Secret Message API

This application reads environment variable SECRET_MESSAGE and sets up an API endpoint `/secret` that will return the secret message

## Prerequisites

1. Go (> 1.11)
2. Docker

## Configuration

Set these environment variables

1. PORT -> the port the http server will be exposed on (default 8080)
2. SECRET_MESSAGE -> the env var where the secret is stored
