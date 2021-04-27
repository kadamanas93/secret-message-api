output "app_ecr_url" {
  value = aws_ecr_repository.secret_api.repository_url
}