# 1. Networking & Subnetting (AWS VPC Setup)

This folder contains the Terraform configuration for setting up the foundational AWS network infrastructure using the Free Tier resources.

## 🚀 Design Explanation

My approach establishes a standard, resilient **VPC architecture** (`10.0.0.0/16`) spanning two Availability Zones (AZs). This design includes two **Public Subnets** (for public-facing services like Load Balancers and NAT Gateway) and two **Private Subnets** (for application servers). An **Internet Gateway (IGW)** allows public subnets to connect to the internet. A **NAT Gateway (NGW)**, placed in a public subnet, provides instances in the private subnets with a secure route for outbound traffic (updates/patches) without exposing them to unsolicited inbound connections.

---

## 🔑 CIDR Ranges Used

| Component | CIDR Range | Description |
| :--- | :--- | :--- |
| **VPC** | `10.0.0.0/16` | Large block providing 65,536 private IPs for future expansion. |
| **Public Subnet 1 (AZ-A)** | `10.0.1.0/24` | Reserved for public components (e.g., Load Balancer, NAT Gateway). |
| **Public Subnet 2 (AZ-B)** | `10.0.2.0/24` | Public subnet in the second AZ for redundancy. |
| **Private Subnet 1 (AZ-A)** | `10.0.11.0/24` | Reserved for internal application resources. |
| **Private Subnet 2 (AZ-B)** | `10.0.12.0/24` | Private subnet in the second AZ for high availability. |

---

## 🖼️ Infrastructure Screenshots

1.  **VPC Details:** 
2.  **Subnets:** 
3.  **Route Tables:** 
4.  **NAT Gateway + IGW:** 

---

## 💻 Terraform Code

The IaC for this setup is located in `main.tf` within this folder.