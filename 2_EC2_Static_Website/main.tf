# Define AWS Provider and Region
provider "aws" {
  region = "eu-north-1"
}

# Referencing Task 1 Resources
data "aws_vpc" "selected" {
  tags = { Name = "Sneha_Prajapati_VPC" }
}

data "aws_subnet" "public_a" {
  tags = { Name = "Sneha_Prajapati_Public_A" }
}

# --- Security Group for EC2 ---
resource "aws_security_group" "web_sg" {
  vpc_id = data.aws_vpc.selected.id
  name   = "Sneha_Prajapati_Web_SG_Task2"

  # Inbound Rule: Allow HTTP (80) from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # Outbound Rule: Allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "Sneha_Prajapati_Web_SG_Task2" }
}

# --- Nginx Installation Script (User Data) ---
locals {
  user_data_script = <<-EOT
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install -y nginx

    echo "
    <!DOCTYPE html>
    <html>
    <head>
        <title>Sneha Prajapati - Static Resume</title>
        <style>body { font-family: Arial, sans-serif; margin: 40px; } h1 { color: #333; }</style>
    </head>
    <body>
        <h1>Sneha Prajapati - Resume</h1>
        <h2>Static Website Deployment Successful!</h2>
        <p>This resume is hosted on a Free Tier EC2 instance using Nginx.</p>
    </body>
    </html>
    " | sudo tee /var/www/html/index.html

    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOT
}

# --- EC2 Instance ---
resource "aws_instance" "web_server" {
  ami                         = "ami-053b02d6b359f1c7d" # Example: Ubuntu 22.04 LTS (Update if needed for your region)
  instance_type               = "t2.micro" # Free Tier eligible
  subnet_id                   = data.aws_subnet.public_a.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  user_data                   = local.user_data_script
  key_name                    = "your_ssh_key_name" 

  tags = {
    Name = "Sneha_Prajapati_Static_Web_Server"
  }
}

output "website_url" {
  description = "Access the website via this IP on port 80"
  value       = "http://${aws_instance.web_server.public_ip}"
}