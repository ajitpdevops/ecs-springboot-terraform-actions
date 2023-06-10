
# ---------------------------------------------------------------------------------------------------------------------
# SECURITY GROUP FOR ALB
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "alb-sg" {
  name        = "ALB Security Group"
  description = "Allow HTTP Traffic to ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "Allow all inbound traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "Allow all inbound traffic"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.environment}-ALB-SG"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# SECURITY GROUP FOR ECS TASKS
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "ecs-sg" {
  name        = "ECS Security Group"
  description = "Allow Traffic to ECS Cluster"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.microservices
    content {
      description     = "Allow inbound traffic for ${ingress.key} app"
      from_port       = ingress.value.container_port
      to_port         = ingress.value.container_port
      protocol        = "tcp"
      security_groups = [aws_security_group.alb-sg.id]
    }
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# SECURITY GROUP FOR RDS
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "rds-sg" {
  name        = "RDS Security Group"
  description = "Allow Traffic to RDS"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow inbound traffic"
    from_port       = var.rds_port
    to_port         = var.rds_port
    protocol        = "tcp"
    # security_groups = [aws_security_group.alb-sg.id]
    cidr_blocks     = [aws_vpc.main.cidr_block]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
