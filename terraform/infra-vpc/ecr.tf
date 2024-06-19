# Primer repositorio ECR
resource "aws_ecr_repository" "ecr-develop" {
  name                 = "develop"
  image_tag_mutability = "MUTABLE"
}

# Segundo repositorio ECR
resource "aws_ecr_repository" "ecr-testing" {
  name                 = "testing"
  image_tag_mutability = "MUTABLE"
}

# Política de ciclo de vida para el primer repositorio ECR
resource "aws_ecr_lifecycle_policy" "ecr-develop_lifecycle_policy" {
  repository = aws_ecr_repository.ecr-develop.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last 10 images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 10
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}

# Política de ciclo de vida para el segundo repositorio ECR
resource "aws_ecr_lifecycle_policy" "ecr-testing_lifecycle_policy" {
  repository = aws_ecr_repository.ecr-testing.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last 5 images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 5
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}

output "ecr_repository_urls" {
  value = {
    my_app_repo       = aws_ecr_repository.ecr-develop.repository_url,
    my_other_app_repo = aws_ecr_repository.ecr-testing.repository_url,
  }
}
