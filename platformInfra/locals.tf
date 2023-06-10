locals {
  target_group_names = {
    for key, value in var.microservices : "${key}-target-group" => value
  }

  db_creds = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)

  # Get the ecr repository url from remote state 
  # ecr_repositories = data.terraform_remote_state.baseinfra.outputs.ecr_repositories

  ecr_repository_url = {
    for key, microservice in var.microservices :
    key => data.aws_ecr_repository.existing_repositories[key].repository_url
  }
  #   ecr_repositories = {
  #     for key, value in data.terraform_remote_state.baseinfra.outputs.ecr_repositories :
  #     key => "${value}:${format("%v", var.microservices[key])}"
  #   }
  #   ecr_repositories = {
  #     for key, value in data.terraform_remote_state.baseinfra.outputs.ecr_repositories : key => flatten("${value.repository_url}:${var.microservices[key]}")
  #   }
}

