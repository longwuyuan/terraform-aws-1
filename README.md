# Terraform for AWS - example

Terraform example for one RDS instance & One EC2 instance ;

## Requirements
- The VPC & its Subnets is pre-created outside of terraform
- Terraform version > 0.12
- Ansible
- AWS credentials in $HOME/.aws/ as per terraform default
- terraform.tfvars as below

```
region     = "us-west-1"
vpc_id     = "vpc-nhg20ks8"
```
- Modify vars.tf, in root folder, if required 

## Caution - read & understand the impact of kms module. Takes 7 days to remove a key after destroy
 
## Creates ;
- kms key
- random string for rds password
- ssm parameter for rds password
- securitygroup for rds postgres
- subnetgroupname for rds
- rds postgres instance
- ec2 instance
- sshkey for ec2 instance
- role for ec2 instance
- securitygroup for ec2 instance

## Other things done
- RDS instance is seeded with some sample data to be presented on a webpage
- Ansible installs Nginx
- A simple python scripts queries the RDS and presents the data there on homepage of nginx
