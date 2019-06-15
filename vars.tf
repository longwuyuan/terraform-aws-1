variable "region" {
  default = "us-west-2"
}
variable "vpc_id" {}
variable "kms_key_id" {}

# Variables for db modules
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
  default = 8
}
variable "db_name" {
  default = "pgdb"
}
variable "db_username" {
  default = "pgdbuser"
}
variable "awsami" {
  type = map(string)
  default = {
    us-east-1 = "ami-0c1b880a476bb7b40"
    us-west-2 = "ami-0cb72367e98845d43"
  }
}
