# Check if the repository already exists
data "aws_ecr_repository" "existing_repositories" {
  for_each = var.microservices

  name = each.key
}


# Create ECR repository for each microservice if it doesn't exist
resource "aws_ecr_repository" "microservices" {
  for_each = {
    for key, microservice in var.microservices :
    key => microservice
    if data.aws_ecr_repository.existing_repositories[key].name != key
  }

  name                 = each.key
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${each.key}-app"
  }
}


locals {
    ecr_repository_urls = {
        for key, microservice in var.microservices :
        key => data.aws_ecr_repository.existing_repositories[key].repository_url
    }
}