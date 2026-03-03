# Lab 9
### Jasmeen Sandhu, Augustin Nguyen, Maksym Buhai
### Setup

1. Clone the repo
    
    ```bash
    git clone https://gitlab.com/cit_4640/4640-w10-lab-start-w25
    cd 4640-w10-lab-start-w25
    ```
    
2. Create new SSH key
    
    ```bash
    sudo ssh-keygen -t ed25519 -f week9
    ```
    
3. Add a new SSH key using scripts/import_lab_key
    
    ```bash
    sudo chmod +x scripts/import_lab_key
    ./scripts/import_lab_key <path to key>
    ```
    
4. Create a new AMI using the Packer and Ansible configuration
    
    ```bash
    cd packer
    packer init .
    packer fmt .
    packer validate .
    packer build .
    ```
    
### Create Module

1. Create new directory to hold the module
    
    ```bash
    cd ../terraform
    mkdir modules/web-server
    ```
    
2. Create and define the [variables.tf](http://variables.tf) file
    
    ```bash
    cd modules/web-server
    nano variables.tf
    ```

    ```hcl
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
    ```

3. Create and define the [outputs.tf](http://outputs.tf) file
    
    ```bash
    nano outputs.tf
    ```

    ```hcl
    # include the following outputs
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
    ```
    
4. Create and define the [main.tf](http://main.tf) file
    
    ```bash
    nano main.tf
    ```

    ```hcl
    resource "aws_instance" "web" {
      ami                    = var.ami
      instance_type          = var.instance_type
      key_name               = var.key_name
      vpc_security_group_ids = var.vpc_security_group_ids
      subnet_id              = var.subnet_id
    
      tags = {
        Name    = "Web"
        Project = var.project_name
      }
    }
    ```

### Cleanup

1. Run terraform destroy
    
    ```bash
    cd ../..
    terraform destroy
    ```

2. Remove AMI and snapshot build

3. Delete SSH key
    
    ```bash
    cd ..
    sudo chmod +x ./scripts/delete_lab_key
    ./scripts/delete_lab_key
    ```
