# AWS Cloud Practitioner Assessment: Infrastructure as Code (IaC)

## 🚀 Repository Structure

This repository contains the required deliverables for the AWS assessment, organized into five separate folders, one for each task. Each folder includes the relevant Terraform code, a detailed explanation, and screenshots documenting the implemented infrastructure.

| Folder | Task Title | Key AWS Services Used | Status |
| :--- | :--- | :--- | :--- |
| `1_VPC_Networking` | VPC & Subnetting Setup | VPC, Subnet, IGW, NAT Gateway, Route Tables | Complete |
| `2_EC2_Static_Website` | EC2 Static Website Hosting | EC2, Security Groups, Nginx, Public Subnet | Complete |
| `3_HA_AutoScaling` | High Availability & Auto Scaling | ALB, ASG, Launch Templates, Private Subnets | Complete |
| `4_Billing_Cost_Monitoring`| Cost Monitoring & Alerts | CloudWatch Billing Alarm, Billing Preferences | Complete |
| `5_Architecture_Diagram`| Scalable Architecture Design | ALB, ASG, RDS Aurora, ElastiCache, WAF | Complete |

---

## ✅ Final Submission Requirements

| Requirement | Status | Location |
| :--- | :--- | :--- |
| Explanations for all 5 sections | ✔️ | In the `README.md` file within each respective folder. |
| AWS Screenshots for each task | ✔️ | In the `README.md` file within each respective folder. |
| Terraform Code | ✔️ | In the `main.tf` file within each respective folder. |
| **GitHub Repository Link** | **✔️** | `https://github.com/Sneha-3110/Sneha_Prajapati_AWS_Task.git` |
---

## 🧹 Cleanup Confirmation

All AWS resources created for this assessment have been successfully terminated using `terraform destroy` to ensure no charges are incurred on the AWS Free Tier account.