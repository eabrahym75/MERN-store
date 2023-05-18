output "alb_dns_name" {
  value       = aws_lb.terra-ec2.dns_name
  description = "The domain name of the load balancer"
}

output "security_groups" {
  value       = aws_security_group.my_asg.id
  description = "The ID of the Security Group attached to the load balancer"
}