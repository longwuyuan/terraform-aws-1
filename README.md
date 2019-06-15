# Terraform for AWS - example

Terraform example for one RDS instance & One EC2 instance ;
- The VPC & its Subnets is pre-created outside of terraform

## Requirements
- Terraform version > 0.12
- Ansible
- AWS credentials in $HOME/.aws/ as per terraform default
- terraform.tfvars as below

```
region     = "us-west-1"
vpc_id     = "vpc-nhg20ks8"
kms_key_id = ""
db_sg_id   = ""
db_password = ""
sshkeyname = ""
```
- Modify vars.tf, in root folder, as required 

## Caution - read & understand the impact of kms module

## Features 
- Creates ;
        - kms key
        - random string for rds master-password
        - ssm parameter for rds master-password
        - securitygroup for rds postgres
        - subnetgroupname for rds
        - rds postgres instance
        - ec2 instance
- RDS instance is seeded with some sample data to be presented on a webpage
- Ansible installs Nginx
- A simple python scripts queries the RDS and presents the data there on homepage of nginx
