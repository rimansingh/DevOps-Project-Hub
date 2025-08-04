# main.tf
provider "aws" {
  region = "us-east-1"  # or your preferred region
}

# Create IAM role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Create EC2 instances
resource "aws_instance" "master" {
  ami           = "ami-0c02fb55956c7d316"  # Ubuntu AMI ID
  instance_type = "t2.micro"
  key_name      = "your-key-name"          # Replace with your key pair name
  
  tags = {
    Name = "Master-Instance"
  }

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}

resource "aws_instance" "slaves" {
  count         = 3
  ami           = "ami-0c02fb55956c7d316"  # Ubuntu AMI ID
  instance_type = "t2.micro"
  key_name      = "your-key-name"          # Replace with your key pair name

  tags = {
    Name = "Slave-${count.index + 1}"
  }

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}

# Security group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from anywhere"
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