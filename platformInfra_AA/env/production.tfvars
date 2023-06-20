# Remote State
remote_state_key="env:/production/STAGE/baseinfra.tfstate"
remote_state_bucket="ecs-terraform-backend-state"

# Environment & Region
environment = "prod"
aws_region = "us-east-1"



# Manage Microservices
service = {
    name                  = "coupon"    
    container_port        = 8080
    spring_profiles       = "prod"
    per_container_cpu     = 512
    per_container_memory  = 1024
    health_check_path     = "/health"
    path_pattern          = "/auth"
    desired_task_count    = 2
}
