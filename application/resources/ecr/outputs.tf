output "aws_ecr_repository_url" {
  description = "ECR Url"
  value = aws_ecr_repository.main.repository_url
}

output "ecr" {
  description = "ECR Object"
  value       = aws_ecr_repository.main
}
