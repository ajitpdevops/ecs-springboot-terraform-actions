
# Create a security group for ALB
resource "aws_security_group" "alb-sg" {
  name        = "${var.environment}-ALB-SG"
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

# Create a security group for ECS to allow 8080 8081 & 3000 ports

resource "aws_security_group" "ecs-sg" {
  name        = "${var.environment}-ECS-SG"
  description = "Allow Traffic to ECS Cluster"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.microservices
    content {
      description = "Allow inbound traffic for ${ingress.key} app"
      from_port   = ingress.value.container_port
      to_port     = ingress.value.container_port
      protocol    = "tcp"
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

# Create a security group for postgres

resource "aws_security_group" "rds-sg" {
  name        = "${var.environment}-RDS-SG"
  description = "Allow Traffic to RDS"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow inbound traffic"
    from_port       = var.rds_port
    to_port         = var.rds_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs-sg.id]
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
