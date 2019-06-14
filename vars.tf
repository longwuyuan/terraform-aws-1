variable "region" {
  default = "us-west-2"
}
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
variable "sshpubkey" {
  default = "/home/me/Documents/.ssh/id_rsa.pub"
}
variable "sshkeyname" {}
variable "awsami" {
  type = map(string)
  default = {
    us-east-1 = "iami-0c1b880a476bb7b40"
    us-west-2 = "ami-0e63f50857fdc1f9f"
  }
}
