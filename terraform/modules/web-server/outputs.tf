output "instance_ip" {
  value = aws_instance.web.public_ip
  description = "The instance IP address"
}

output "instance_dns" {
  value = aws_instance.web.public_dns
  description = "The instance DNS name"
}

output "instance_id" {
  value = aws_instance.web.id
  description = "The instance ID"
}
