provider "aws" {
  region = var.REGION
}

module "kms" {
  source = "./kms/"
}
# Create the postgres db
module "postgres" {
  source               = "./pgdb/"
  KMS_KEY_ID           = module.kms.kmskeyid
  DB_IDENTIFIER        = var.DB_IDENTIFIER
  DB_ENGINE            = var.DB_ENGINE
  DB_ENGINE_VERSION    = var.DB_ENGINE_VERSION
  DB_INSTANCE_CLASS    = var.DB_INSTANCE_CLASS
  DB_ALLOCATED_STORAGE = var.DB_ALLOCATED_STORAGE
  DB_NAME              = var.DB_NAME
  DB_USERNAME          = var.DB_USERNAME
  DB_PASSWORD          = var.DB_PASSWORD
  SECURITYGROUP_ID     = var.SECURITYGROUP_ID
  DB_SUBNETGROUP_NAME  = var.DB_SUBNETGROUP_NAME
}
