# ./modules/webserver/vars.tf

variable "region" {}
variable "vpc_id" {}
variable "kms_key_id" {}
variable "awsami" {}
variable "sshpubkey" {
  default = "/home/me/Documents/.ssh/id_rsa.pub"
}
