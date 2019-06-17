# ./modules/webserver/vars.tf

variable "region" {}
variable "vpc_id" {}
variable "kms_key_id" {}
variable "awsami" {}
variable "sshpubkey" {
  default = "./modules/webserver/id_rsa.pub"
}
variable "sshprivkey" {
  default = "./modules/webserver/id_rsa"
}
variable "rds_endpoint" {}
