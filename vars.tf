variable "region" {}
variable "vpc_id" {}
variable "kms_key_id" {}
variable "db_sg_id" {}
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
variable "db_password" {}
