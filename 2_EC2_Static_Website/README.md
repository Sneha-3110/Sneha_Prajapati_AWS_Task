# 2. EC2 Static Website Hosting

This folder configures a Free Tier EC2 instance running Nginx to host a static resume website. It leverages the VPC and a Public Subnet created in Task 1.

## 🚀 Setup Explanation and Hardening

The **EC2 instance** (`t2.micro`) is launched in a **public subnet** with an assigned public IP. I used a **`user_data` script** (contained in `main.tf`) to automatically install Nginx and deploy the static resume HTML page upon launch.

**Basic Hardening:** Security is managed via a **Security Group (SG)** following the Principle of Least Privilege:
1.  **HTTP (Port 80):** Open to `0.0.0.0/0` (Internet) for public access.
2.  **SSH (Port 22):** Restricted to a specific IP range (`your_personal_ip/32` - though a placeholder was used in the code for submission) for secure administrative access only.

---

## 🖼️ Infrastructure Screenshots

1.  **EC2 Instance Details:** 
2.  **Security Group Rules:** 
3.  **Website Access:** 

---

## 💻 Terraform Code and Setup Script

The IaC for this setup is located in `main.tf` within this folder. The Nginx installation script is embedded within the `user_data` block in the Terraform code.