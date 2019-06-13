# Terraform example

Terraform example for one RDS instance & One EC2 instance ;
- The VPC & its Subnets & the RDS db-subnetgroup is pre-created outside of terraform, using AWS Console
- terraform.tfvars is populated by copy/pasting from the AWS-Console (see tfvars.example)

```
    REGION               = "us-west-1"
    VPC_ID               = "vpc-0e922297898kj9314"
    SUBNET_ID            = ["subnet-07i56723jgfkj4467", "subnet-hsd8s8930f89sss66"]
    SECURITYGROUP_ID     = ["sg-02d863636j7s0s4s9"]
    DB_IDENTIFIER        = "PGDBDBSERVER"
    DB_ENGINE            = "postgres"
    DB_ENGINE_VERSION    = "11.2"
    DB_INSTANCE_CLASS    = "db.t2.micro"
    DB_ALLOCATED_STORAGE = 8
    DB_NAME              = "PGDB"
    DB_USERNAME          = "pgdbuser"
    DB_PASSWORD          = "pgdbuserpassword123"
    DB_SUBNETGROUP_NAME  = "PGDBSERVER-SUBNETGROUP"
    AMI_ID               = "ami-010cb9019f3021398"
```

        - For parsing by terraform, the subnet-id & securutygroup-id in terrraform.tfvars, needs to be quoted strings in braces, with multiple values seperated by a comma

```
        ["subnet-00d0d0a5ed3979267","subnet-0da09252kj9b9cc66"]
```
- RDS instance uses postgres engine and non-default VPC+subnet
- RDS instance uses KMS key
- RDS instance uses aws_ssm_parameter
- RDS instance is seeded with some sample data to be presented on a webpage

- EC2 instance is in the same non-default VPC
- Ansible installs Nginx
- A simple python scripts queries the RDS and presents the data there on homepage of nginx