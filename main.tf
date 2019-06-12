provider "aws" {
  region = var.REGION
}

module "postgres" {
  source = "./pgdb/"
  DB_IDENTIFIER = var.DB_IDENTIFIER
  DB_ENGINE = var.DB_ENGINE
  DB_ENGINE_VERSION = var.DB_ENGINE_VERSION
  DB_INSTANCE_CLASS = var.DB_INSTANCE_CLASS
  DB_ALLOCATED_STORAGE = var.DB_ALLOCATED_STORAGE
  DB_NAME = var.DB_NAME
  DB_USERNAME = var.DB_USERNAME
  DB_PASSWORD = var.DB_PASSWORD
  SECURITY_GROUP_ID = var.SECURITY_GROUP_ID
  DB_SUBNET_GROUP_NAME = var.DB_SUBNET_GROUP_NAME
}