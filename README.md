# TechCorp AWS Infrastructure Deployment 🚀

Welcome to the TechCorp Month 1 Assessment project! This repository contains a complete Infrastructure as Code (IaC) solution using **Terraform** to automatically provision a highly available, secure, and scalable web application environment on Amazon Web Services (AWS).

---

## 🏗️ Architecture Overview

This project deploys a robust, production-ready AWS architecture designed for security and high availability. 

### Network Infrastructure
- **Virtual Private Cloud (VPC)**: A secure, isolated network (`10.0.0.0/16`) serving as the foundation for all resources.
- **Public Subnets**: Two public subnets distributed across different Availability Zones (AZs). These host internet-facing resources like the Load Balancer and Bastion Host.
- **Private Subnets**: Two private subnets across different AZs. These host the internal application servers and database, strictly isolating them from direct internet access.
- **Gateways**: An Internet Gateway for public subnet traffic, and two NAT Gateways (one per public subnet) allowing outbound internet access for the private servers (e.g., to download software updates).

### Compute & Application
- **Bastion Host** (`t3.micro`): A secure gateway located in the public subnet. It acts as the only entry point for administrators to SSH into the internal servers.
- **Application Load Balancer (ALB)**: Distributes incoming HTTP web traffic evenly across the web servers in the private subnets to ensure high availability.
- **Web Servers** (2x `t3.micro`): Hosted in private subnets. They are automatically configured on startup (via User Data scripts) to run an Apache HTTP server and serve dynamic content.
- **Database Server** (1x `t3.small`): Hosted in a private subnet, configured on startup to run PostgreSQL.

### Security
- **Strict Security Groups**: 
  - The Web servers only accept HTTP/HTTPS traffic from the public, and SSH traffic *exclusively* from the Bastion host.
  - The Database server only accepts PostgreSQL traffic (Port 5432) from the Web servers, and SSH traffic from the Bastion host.
  - The Bastion host restricts SSH access strictly to the Administrator's configured Public IP.

---

## 📋 Prerequisites

Before deploying this infrastructure, ensure you have the following:
1. An active **AWS Account**.
2. **AWS CLI** installed and authenticated (or a configured `~/.aws/credentials` file).
3. **Terraform** installed on your local machine.
4. An existing **AWS EC2 Key Pair** (e.g., `keypair.pem`) in your chosen AWS Region.
5. Your current **Public IP Address** (to allow you to securely SSH into the Bastion Host).

---

## 🚀 Deployment Instructions

Follow these steps to deploy the environment from your terminal:

### 1. Configuration
First, copy the example variables file to create your active configuration file:
```bash
cp terraform.tfvars.example terraform.tfvars
```
Open `terraform.tfvars` and update the following values:
* `aws_region`: Your desired AWS region (e.g., `eu-west-2`).
* `key_pair_name`: The exact name of your EC2 Key Pair as it appears in the AWS Console (e.g., `keypair`).
* `admin_ip`: Your public IP address in CIDR format (e.g., `102.90.115.147/32`).

### 2. Initialize Terraform
Download the necessary AWS provider plugins:
```bash
terraform init
```

### 3. Plan the Deployment
Review the resources Terraform is about to create:
```bash
terraform plan
```
*(Note: Be sure to take a screenshot of this output for your assessment evidence!)*

### 4. Apply the Configuration
Build the infrastructure:
```bash
terraform apply
```
Type `yes` when prompted. This process will take 2-5 minutes as the EC2 instances and Load Balancer are provisioned. 
*(Take a screenshot of the "Apply complete!" message).*

---

## 🧪 Verification & Testing

When the deployment finishes, Terraform will output three important values: `vpc_id`, `bastion_public_ip`, and `load_balancer_dns_name`.

### Testing Web Access
1. Copy the `load_balancer_dns_name` and paste it into your web browser. 
2. You should see a "Welcome to TechCorp Web Server!" page displaying an Instance ID. 
3. Refresh the page a few times—you will see the Instance ID change as the Load Balancer routes you between the two different web servers!

### Testing SSH Access
1. **Access the Bastion Host:**
   ```bash
   ssh -i "/path/to/your/keypair.pem" ec2-user@<bastion_public_ip>
   ```
2. **Access the Private Web/DB Servers:**
   Once inside the Bastion Host, find the private IP address of your web or database server from the AWS Console, and SSH into it:
   ```bash
   ssh ec2-user@<private_ip_of_server>
   ```
   *Password: `TechCorp123!`*

---

## 🧹 Cleanup Instructions

**CRITICAL:** Cloud resources cost money! When you are finished exploring the infrastructure and have taken all your required screenshots, you must destroy the environment to avoid recurring AWS charges.

Run the following command:
```bash
terraform destroy
```
Type `yes` when prompted. Wait for the confirmation that all resources have been successfully destroyed.

---
*Created for the TechCorp Month 1 Assessment.*
