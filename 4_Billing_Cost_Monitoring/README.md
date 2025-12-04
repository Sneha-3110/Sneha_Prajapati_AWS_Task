# 4. Billing & Free Tier Cost Monitoring

This task involves configuring proactive cost management alerts within the AWS account console.

## 🚀 Explanation of Cost Monitoring

### a) Importance of Cost Monitoring

Cost monitoring is **critical for beginners** to prevent **unexpected "bill shock."** The complexity of AWS pricing (charges for usage, storage, and data transfer) means forgetting a resource or exceeding the Free Tier limit can quickly lead to high costs. Setting an alarm at a low threshold (like ₹100) and enabling Free Tier alerts ensures **proactive resource management** and provides immediate feedback on usage.

### b) Causes of Sudden Bill Increases

Sudden increases are typically caused by:
1.  **Forgotten Resources:** Leaving non-Free Tier services (like larger EC2 instances or RDS databases) running after experiments are finished.
2.  **Exceeding Free Tier Limits:** Usage past the monthly limits (e.g., 750 hours of `t2.micro`, 5GB of S3 storage) is charged at standard rates.
3.  **High Data Egress:** Transferring large volumes of data *out* of AWS to the public internet, which incurs high data transfer costs.

---

## 🖼️ Screenshots

1.  **CloudWatch Billing Alarm:** 
2.  **Free Tier Usage Alerts:**