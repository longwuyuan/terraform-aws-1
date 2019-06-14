# Terraform example

Terraform example for one RDS instance & One EC2 instance ;
- The VPC & its Subnets is pre-created outside of terraform
- terraform.tfvars is populated by copy/pasting from the AWS-Console (see tfvars.example)

```
region     = "us-west-1"
vpc_id     = "vpc-nhg20ks8"
kms_key_id = ""
db_sg_id   = ""
```
```
- RDS instance uses postgres engine and non-default VPC+subnet
- RDS instance uses KMS key
- RDS password is in aws_ssm_parameter
- RDS instance is seeded with some sample data to be presented on a webpage

- EC2 instance is in the same non-default VPC
- Ansible installs Nginx
- A simple python scripts queries the RDS and presents the data there on homepage of nginx
