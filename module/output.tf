output "server-ip" {
  description = "Public Ip Address of Server Instance"
  value = aws_launch_configuration.terra-ec2.id
}