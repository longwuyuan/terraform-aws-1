# Gotchas

- VPC, Subnets & DB_SUBNET_GROUP already created outside of terraform manually

- terraform.tfvars manually populated by copy/pasting from the AWS-Console

- subnet-id in terrraform.tfvars has to be in the format ;

    ["subnet-00d0d0a5ed3979267","subnet-0da09252kj9b9cc66"]

- securitygroup-id also has to be in a similar format i.e. quoted strings in braces, seperated by comma
