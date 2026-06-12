output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "load_balancer_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.web_alb.dns_name
}

output "bastion_public_ip" {
  description = "The public Elastic IP address of the Bastion Host"
  value       = aws_eip.bastion_eip.public_ip
}
