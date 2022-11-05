output "aws_ecr_repository_url" {
  description = "ECR Url"
  value       = aws_ecr_repository.ecr.repository_url
}

output "ecr" {
  description = "ECR Url"
  value       = aws_ecr_repository.ecr
}
