# Terraform for AWS - example

Terraform example for one RDS instance & One EC2 instance ;

## Pre-requisies
- Terraform version > 0.12 in $PATH
- Ansible recent version
- AWS credentials in $HOME/.aws/ 
- VPC pre-created before running terraform here
- File terraform.tfvars should contain these four variables

```
region     = "us-west-1"
vpc_id     = "vpc-nhg20ks8"
kms_key_id   = ""
rds_endpoint = ""
```
- Generate a ssh keypair named as id_rsa and id_rsa.pub in ./modules/webserver folder. Don't set a password to the priv key ;

```
    ssh-keygen -t rsa
```
- Modify vars.tf, in root folder, if required 

## Caution - read & understand the impact of kms module. Takes 7 days to remove a key after destroy
 
## This code creates ;
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
- Ansible installs Nginx postgresql client
- A simple python scripts queries the RDS and presents the data there on homepage of nginx
- TODO: Several cleanups and improvements
