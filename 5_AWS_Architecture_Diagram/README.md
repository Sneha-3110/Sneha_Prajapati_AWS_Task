# 5. AWS Architecture Diagram (Highly Scalable Web Application)

This folder contains the architecture diagram and explanation for a highly scalable web application designed to handle 10,000 concurrent users.

## 🚀 Architecture Explanation

The chosen architecture is a **Multi-AZ, three-tier, decoupled pattern** engineered for resilience, performance, and scalability.

1.  **Load Balancing & Security:** An **Internet-facing ALB** (potentially fronted by **AWS WAF**) distributes traffic.
2.  **Application Tier:** An **Auto Scaling Group (ASG)** of application servers resides in **private subnets**, providing horizontal scaling and fault tolerance across AZs.
3.  **Caching:** An **ElastiCache (Redis)** layer handles session state and read caching, reducing latency and database load.
4.  **Data Tier:** A **Multi-AZ Amazon Aurora** (or RDS) instance provides high availability and durability in separate, secure private data subnets.
5.  **Security & Observability:** All inter-tier communication is governed by strict **Security Groups (SGs)** and **NACLs**. **CloudWatch** provides comprehensive monitoring for proactive scaling and health checks.

---

## 🖼️ Architecture Diagram