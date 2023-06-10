data "aws_secretsmanager_secret" "secrets" {
  arn = data.terraform_remote_state.baseinfra.outputs.secret_manager_arn
}

data "aws_secretsmanager_secret_version" "creds" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}


data "aws_ecr_repository" "existing_repositories" {
  for_each = var.microservices
  name = each.key
}