locals {
#   target_group_names = {
#     for key, value in var.microservices : "${key}-target-group" => value
#   }

  db_creds = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)

  # Get the ecr repository url from remote state 
  ecr_repositories = data.terraform_remote_state.baseinfra.outputs.ecr_repositories
}

