provider "aws" {
  region = var.region
}

# Create kms key
module "kms" {
  source = "./kms/"
}

# Store db-pass to ssm
module "ssm" {
  source      = "./ssm"
  db_password = var.db_password
  kms_key_id  = module.kms.kmskeyid
}

# Create securitygroup
module "sg" {
  source = "./sg"
  vpc_id = var.vpc_id
}

# Create postgres db
module "db" {
  source               = "./db/"
  vpc_id               = var.vpc_id
  db_sg_id             = module.sg.sg_id
  kms_key_id           = module.kms.kmskeyid
  db_identifier        = var.db_identifier
  db_engine            = var.db_engine
  db_engine_version    = var.db_engine_version
  db_instance_class    = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  db_subnetgroup_name  = var.db_subnetgroup_name
}
