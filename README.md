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
        sudo +x scripts/import_lab_key
        ./scripts/import_lab_key
        ```
        
    4. Create a new AMI using the Packer and Ansible configuration
        
        ```bash
        cd /packer
        packer init .
        packer fmt .
        packer validate .
        packer build .
        ```
        
    
    ### Create Module
    
    1. Create new directory to hold the module
        
        ```bash
        cd /terraform
        mkdir modules/web-server
        ```
        
    2. Create and define the [variables.tf](http://variables.tf) file
        
        ```bash
        cd modules/web-server
        nano variables.tf
        
        # include the following variables
        project_name" {
          type = string
        }
        
        variable "ami" {
          type = string
        }
        
        variable "instance_type" {
          type    = string
          default = "t3.micro"
        }
        
        variable "key_name" {
          type = string
        }
        
        variable "vpc_security_group_ids" {
          type = list(string)
        }
        
        variable "subnet_id" {
          type = string
        }
        ```
        
    3. Create and define the [outputs.tf](http://outputs.tf) file
        
        ```bash
        nano outputs.tf
        
        # include the following outputs
        output "instance_ip_address" {
          value = aws_instance.web.public_ip
        }
        
        output "instance_dns_name" {
          value = aws_instance.web.public_dns
        }
        
        output "instance_id" {
          value = aws_instance.web.id
        }
        ```
        
    4. Create and define the [main.tf](http://main.tf) file
        
        ```bash
        nano main.tf
        
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
        terraform destroy
        ```
        
    2. Remove AMI and snapshot build 
    3. Delete SSH key
        
        ```bash
        sudo +x ./scripts/remove_lab_key
        ./scripts/remove_lab_key
        ```
