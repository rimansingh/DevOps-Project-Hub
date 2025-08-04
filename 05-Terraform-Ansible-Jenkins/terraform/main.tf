# Provider configuration
provider "aws" {
    region = "us-east-1"
}

# Security group for instances
resource "aws_security_group" "instance_sg" {
    name        = "instance-sg"
    description = "Security group for instances"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
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

# EC2 instances
resource "aws_instance" "example" {
    count         = 3
    ami           = "ami-0261755bbcb8c4a84"  # Ubuntu 20.04 LTS in us-east-1
    instance_type = "t2.micro"
    key_name      = "your-key-name"
    vpc_security_group_ids = [aws_security_group.instance_sg.id]

    user_data = count.index == 0 ? file("${path.module}/../scripts/user_data.sh") : null

    tags = {
        Name = count.index == 0 ? "Jenkins-Master" : "Jenkins-Slave-${count.index}"
        Role = count.index == 0 ? "master" : "slave"
    }
}

# Output the IPs
output "master_ip" {
    value = aws_instance.example[0].public_ip
    description = "The public IP of the Jenkins master"
}

output "slave_ips" {
    value = [for i in range(1, 3) : aws_instance.example[i].public_ip]
    description = "The public IPs of the Jenkins slaves"
}