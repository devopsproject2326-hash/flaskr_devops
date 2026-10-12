terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "flaskr" {
  name        = "flask-devops-sg"
  description = "Allow web traffic and restricted SSH access"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH for my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["86.182.5.227/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "flaskr_app" {
  ami                    = "ami-05bfa4a7765f38076"
  instance_type          = "t3.micro"
  key_name               = "flaskr-devops-key"
  vpc_security_group_ids = [aws_security_group.flaskr.id]

  tags = {
    Name = "flaskr_devops"
  }
}