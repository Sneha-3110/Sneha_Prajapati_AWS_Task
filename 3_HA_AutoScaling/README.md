# 3. High Availability + Auto Scaling

This folder configures a highly available and scalable architecture for the web application, replacing the standalone EC2 setup.

## 🚀 HA Architecture and Traffic Flow

This design shifts the application servers to **Private Subnets** for enhanced security.

* **Load Balancing:** An **Internet-facing Application Load Balancer (ALB)** is deployed across two public subnets to receive all public traffic.
* **Scalability & HA:** An **Auto Scaling Group (ASG)** maintains the desired capacity (Min: 2, Desired: 2) by launching Free Tier EC2 instances across both **private subnets** (Multi-AZ). The ASG ensures instances are automatically replaced if they fail.
* **Routing:** The ALB routes traffic to a **Target Group (TG)**, which health-checks and distributes requests to the private IPs of the EC2 instances launched by the ASG.

**Traffic Flow:** User $\rightarrow$ ALB (Public Subnets) $\rightarrow$ Target Group $\rightarrow$ EC2 Instances (Private Subnets).

---

## 🖼️ Infrastructure Screenshots

1.  **ALB Configuration:** 
2.  **Target Group:** 
3.  **Auto Scaling Group:** 
4.  **EC2 Instances via ASG:** 

---

## 💻 Terraform Code

The IaC for this HA setup is located in `main.tf` within this folder.