# 🚀 Terraform AWS Infrastructure for MERN Application (3-Tier Architecture)

This project provisions a **highly-available**, **scalable**, and **modular** AWS infrastructure using Terraform to host a production-ready **MERN stack application** in a **three-tier architecture**:

- **Frontend** (React) served on port `3000`
- **Backend** (Node.js + Express API) on port `5001`
- **Database** (MongoDB) managed via Docker inside private EC2 instances

---

## 🌐 Architecture Overview

![image](https://github.com/user-attachments/assets/9a10ac64-b052-4299-8eab-ed83e7f7fc3d)

               +--------------------------+
               |     Internet Gateway     |
               +-----------+--------------+
                           |
                 +---------▼---------+
                 |   Application Load  |
                 |     Balancer (ALB)  |
                 +---------+----------+
                           |
                +----------▼-----------+
                |   Public Subnets      |
                |  (2 Availability Zones) |
                | Bastion Host + NAT GW |
                +----------+-----------+
                           |
                +----------▼-----------+
                |   Private Subnets     |
                |  (2 Availability Zones) |
                |   Auto Scaling Group  |
                |  MERN App via Docker  |
                +----------------------+



---

## 🛠 Features

- 🔐 **Private deployment** of app — backend/frontend are only accessible via Load Balancer.
- 🛡️ **Security groups** for ALB, app instances, and Bastion host.
- 🌐 **NAT Gateways** in each AZ for private subnet egress.
- 🔁 **Auto Scaling Group (ASG)** with Launch Template for MERN container deployment.
- 📦 **Docker Compose-based deployment** using provisioners.
- ☁️ **Remote Terraform backend** using S3 + DynamoDB for locking.
- 📦 **Reusable modules** designed for real-world use.

---

## 🔧 Technologies Used

- **AWS Services**: EC2, VPC, Subnets, IGW, NAT Gateway, S3,  ALB, ASG
- **Terraform**: Modular infrastructure as code
- **Docker & Docker Compose**: Containerized MERN stack
- **SSH Bastion Host**: Secure access to private EC2

---

## 🚦 How to Deploy

> ⚠️ You should have a valid AWS key and secret exported in your environment.

### 1. Clone the Repo
```bash
git clone https://github.com/yourname/terraform-aws-mern-app.git
cd terraform-aws-mern-app
### 2 . Intialize terraform
terraform init
terraform apply


📂 Future Improvements
Add workspace support (dev, prod)

Integrate CI/CD (e.g., GitHub Actions)

Add Route53 for custom domain & HTTPS via ACM

Migrate DB to managed service (e.g., MongoDB Atlas or DocumentDB)
