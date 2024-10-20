terraform {
  
  cloud {
    organization = "jases-terraforming-business"

    workspaces {
      name = "fastapi-json-api"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "app_sg" {
  name = "app_security_group"

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-06b21ccaeff8cd686"
  instance_type = "t2.micro"
  
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    # Install Docker
    sudo yum update -y
    sudo yum install docker
    sudo service docker start
    sudo usermod -a -G docker ec2-user
  EOF
  
  tags = {
    Name = var.instance_name
  }
}