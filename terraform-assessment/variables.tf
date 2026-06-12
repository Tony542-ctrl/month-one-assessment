variable "aws_region" {
  description = "The AWS region to deploy resources to"
  type        = string
  default     = "us-east-1"
}

variable "bastion_instance_type" {
  description = "The EC2 instance type for the Bastion Host"
  type        = string
  default     = "t3.micro"
}

variable "web_instance_type" {
  description = "The EC2 instance type for the Web Servers"
  type        = string
  default     = "t3.micro"
}

variable "db_instance_type" {
  description = "The EC2 instance type for the Database Server"
  type        = string
  default     = "t3.small"
}

variable "key_pair_name" {
  description = "The name of the SSH key pair to use for the EC2 instances"
  type        = string
}

variable "admin_ip" {
  description = "Your public IP address for SSH access to the Bastion Host (e.g. 203.0.113.5/32)"
  type        = string
}
