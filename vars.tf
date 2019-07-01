# Input variables
# AWS provider variables
variable "region" {}
variable "vpc_id" {}

# Variable for kms
variable "kms_key_id" {}

# Variables for rds module
variable "db_identifier" {
  default = "pgdbserver"
}
variable "db_engine" {
  default = "postgres"
}
variable "db_engine_version" {
  default = "11.2"
}
variable "db_instance_class" {
  default = "db.t2.micro"
}
variable "db_allocated_storage" {
  default = 20
}
variable "db_name" {
  default = "pgdb"
}
variable "db_username" {
  default = "pgdbuser"
}

# Variables for webserver module
variable "awsami" {
  type = map(string)
  default = {
    us-east-1 = "ami-0c1b880a476bb7b40"
    us-west-2 = "ami-0cb72367e98845d43"
  }
}
variable "rds_endpoint" {}
