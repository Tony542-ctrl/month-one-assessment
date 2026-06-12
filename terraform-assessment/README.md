# Month 1 Assessment - TechCorp AWS Infrastructure

This repository contains the Terraform configuration to deploy the new web application infrastructure for TechCorp on AWS.

## Prerequisites

1.  **AWS Account**: You must have an active AWS account.
2.  **AWS CLI**: Installed and configured with appropriate credentials (`aws configure`).
3.  **Terraform**: Installed on your local machine.
4.  **SSH Key Pair**: An existing EC2 Key Pair in your chosen AWS region.

## Configuration

1.  Copy the example variables file:
    ```bash
    cp terraform.tfvars.example terraform.tfvars
    ```
2.  Edit `terraform.tfvars` and provide your specific values:
    *   `aws_region`: The AWS region (e.g., `us-east-1`).
    *   `key_pair_name`: The name of your existing EC2 Key Pair.
    *   `admin_ip`: Your current public IP address in CIDR notation (e.g., `203.0.113.5/32`) to allow SSH access to the Bastion host.

## Deployment Steps

1.  **Initialize Terraform**:
    ```bash
    terraform init
    ```
    This downloads the necessary provider plugins.

2.  **Validate the Configuration**:
    ```bash
    terraform validate
    ```
    This ensures the syntax is correct.

3.  **Plan the Deployment**:
    ```bash
    terraform plan
    ```
    *TAKE A SCREENSHOT OF THIS OUTPUT FOR EVIDENCE.*

4.  **Apply the Configuration**:
    ```bash
    terraform apply
    ```
    Type `yes` when prompted.
    *TAKE A SCREENSHOT OF THE COMPLETION OUTPUT FOR EVIDENCE.*

## Verification

Once deployed, Terraform will output three values:
*   `bastion_public_ip`
*   `load_balancer_dns_name`
*   `vpc_id`

### Web Access
1.  Open a web browser and navigate to the `load_balancer_dns_name` provided in the outputs (e.g., `http://techcorp-web-alb-xxxx.us-east-1.elb.amazonaws.com`).
2.  Refresh a few times to see the Load Balancer distributing traffic between the two web instances (the Instance ID will change).
    *TAKE A SCREENSHOT OF THE BROWSER SHOWING THE PAGE FOR EVIDENCE.*

### SSH Access
1.  **SSH to Bastion Host**:
    ```bash
    ssh -i /path/to/your/keypair.pem ec2-user@<bastion_public_ip>
    ```
    *TAKE A SCREENSHOT OF THE BASTION SSH SESSION FOR EVIDENCE.*

2.  **SSH from Bastion to Web/DB Servers**:
    From inside the Bastion host, you can SSH to the private IP addresses of your web or database servers using the password configured in the user data scripts (`TechCorp123!`):
    ```bash
    ssh ec2-user@<private_ip_of_web_or_db>
    ```
    (You can find the private IPs in the AWS EC2 Console).
    *TAKE A SCREENSHOT OF THE SSH SESSIONS FOR EVIDENCE.*

### Database Access
1.  SSH into the DB Server from the Bastion host.
2.  Connect to Postgres:
    ```bash
    sudo -u postgres psql
    ```
    *TAKE A SCREENSHOT OF THE POSTGRES PROMPT FOR EVIDENCE.*

## Cleanup Instructions

To avoid incurring future charges, completely destroy the infrastructure when you are finished testing:

```bash
terraform destroy
```
Type `yes` when prompted.

## Evidence Folder

Please place all required screenshots into the `evidence/` folder within this repository before submission.
