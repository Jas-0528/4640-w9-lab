variable "project_name" {
  type        = string
  description = "The name of the project these resources belong to"
}

variable "ami" {
  type        = string
  description = "The ID of the machine image to use for the server"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "The EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "The name of the SSH public key"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "The list VPC security group IDs"
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID"
}
