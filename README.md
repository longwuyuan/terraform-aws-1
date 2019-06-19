# Terraform for AWS - example

Terraform example for one RDS instance & One EC2 instance ;

## Pre-requisies
- A working Terraform version > 0.12 in $PATH
- I have tried the new terraform v0.12x syntax where possible
- A working Ansible installation locally (recent version)
- Working valid AWS credentials in $HOME/.aws/ 
- A AWS VPC pre-created before running terraform here
- The file "terraform.tfvars", in root folder here, should contain these four variables

```
region     = "us-west-1"
vpc_id     = "vpc-nhg20ks8"
kms_key_id   = ""
rds_endpoint = ""
```
- You need to generate a ssh keypair named as id_rsa and id_rsa.pub in ./modules/webserver folder. Don't set a password to the priv key ;

```
    ssh-keygen -t rsa
```
- You need to fix permissions on id_rsa.pub

```
    chmod 600 id_rsa.pub
```
- Modify vars.tf, in root folder, if required 

# Caution - read & understand the impact of kms module. Takes 7 days to remove a key after destroy

# Git clone or zip download this repo. Then run ;
        * terraform init
        * terraform plan
        * terraform apply

## Functionalities demonstrated in this example
- kms key created
- random string generated for rds password
- ssm parameter added for rds password
- securitygroup created for rds postgres
- subnetgroupname created for rds
- rds postgres instance crated
- ec2 instance created
- sshkey for ec2 instance created
- role for ec2 instance created
- securitygroup for ec2 instance created
- Ansible installs nginx & php-fpm and changes them to custom config
- RDS credentials are retrieved from ssm and stored on server in /tmp
- (If required, can add a delete step for those creds after configuring php app)
- Ansible copies over a custom tiny index.php that connects to postgres
- Index.php creates a table, inserts a oneliner record and retrieves it from db to render html
- Go to the IP-Address or Hostname of EC2 instance to see index.php working with postgres

- TODO: I would rather do the webpage with python but a single tiny PHP page achieves the same goal that a MVC framwork of flask or django would
- TODO: Several cleanups and improvements
