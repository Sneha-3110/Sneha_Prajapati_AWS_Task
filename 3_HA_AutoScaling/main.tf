# Define AWS Provider and Region
provider "aws" {
  region = "eu-north-1"
}

# --- Data Sources (Referencing Task 1 Resources) ---
data "aws_vpc" "selected" {
  tags = { Name = "Sneha_Prajapati_VPC" }
}
data "aws_subnets" "public" {
  filter { name = "tag:Name" values = ["Sneha_Prajapati_Public_*"] }
}
data "aws_subnets" "private" {
  filter { name = "tag:Name" values = ["Sneha_Prajapati_Private_*"] }
}

# --- Security Groups for ALB and EC2 ---
resource "aws_security_group" "alb_sg" {
  vpc_id = data.aws_vpc.selected.id
  name   = "Sneha_Prajapati_ALB_SG"
  # Allow HTTP inbound from internet
  ingress { from_port = 80; to_port = 80; protocol = "tcp"; cidr_blocks = ["0.0.0.0/0"] }
  # Allow all outbound
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}

resource "aws_security_group" "ec2_sg" {
  vpc_id = data.aws_vpc.selected.id
  name   = "Sneha_Prajapati_ASG_EC2_SG"
  # Allow inbound traffic from the ALB's security group (Port 80)
  ingress { from_port = 80; to_port = 80; protocol = "tcp"; security_groups = [aws_security_group.alb_sg.id] }
  # Allow all outbound (for patches via NAT Gateway)
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}

# --- Application Load Balancer (ALB) ---
resource "aws_lb" "application_lb" {
  name               = "YourFN-LN-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnets.public.ids # ALB goes in Public Subnets
  tags = { Name = "Sneha_Prajapati_ALB" }
}

# --- Target Group (TG) ---
resource "aws_lb_target_group" "app_tg" {
  name     = "YourFN-LN-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected.id
  health_check { path = "/"; protocol = "HTTP"; matcher = "200" }
}

# --- ALB Listener ---
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action { type = "forward"; target_group_arn = aws_lb_target_group.app_tg.arn }
}

# --- Launch Template (Defines EC2 instance config) ---
resource "aws_launch_template" "web_template" {
  name_prefix   = "YourFN-LN-Template"
  image_id      = "ami-053b02d6b359f1c7d" # Ubuntu 22.04 LTS (Update if needed for your region)
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = false # Instances in private subnet
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(<<-EOT
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install -y nginx
    echo "<h1>High Availability Resume Site: Sneha Prajapati </h1>" | sudo tee /var/www/html/index.nginx-debian.html
    sudo systemctl start nginx
    sudo systemctl enable nginx
    EOT
  )
  tag_specifications { resource_type = "instance"; tags = { Name = "Sneha_Prajapati_ASG_Web_Instance" } }
}

# --- Auto Scaling Group (ASG) ---
resource "aws_autoscaling_group" "web_asg" {
  desired_capacity    = 2
  max_size            = 4
  min_size            = 2
  vpc_zone_identifier = data.aws_subnets.private.ids # ASG uses Private Subnets
  target_group_arns   = [aws_lb_target_group.app_tg.arn]

  launch_template {
    id      = aws_launch_template.web_template.id
    version = "$$Latest"
  }
  tags = [{ key = "Name"; value = "Sneha_Prajapati_ASG"; propagate_at_launch = true }]
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.application_lb.dns_name
}