
resource "aws_ecr_repository" "database" {
  name         = "database"
  tags = {
    Name = "A2_database"
  }
}

resource "aws_ecr_repository" "application" {
  name         = "application"
  tags = {
    Name = "A2_application"
  }
}

data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

resource "aws_ecr_repository_policy" "ecr_policy_database" {
  repository = "database"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = data.aws_iam_role.lab_role.arn
        }
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ]
      }
    ]
  })
}


resource "aws_ecr_repository_policy" "ecr_policy_application" {
  repository = "application"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = data.aws_iam_role.lab_role.arn
        }
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ]
      }
    ]
  })
}

