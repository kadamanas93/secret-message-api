resource "aws_secretsmanager_secret" "api_secret_message" {
  name = "secret-api/dev/secret_message"
}

resource "aws_secretsmanager_secret_version" "api_secret_message" {
  secret_id     = aws_secretsmanager_secret.api_secret_message.id
  secret_string = var.secret_message
}