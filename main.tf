provider "aws" {
  region = var.region
}

# Create kms key
module "kms" {
  source = "./kms/"
}

module "dbpassword" {
  source = "./dbpassword"
}

# Store db-pass to ssm
module "ssm" {
  source      = "./ssm"
  db_password = module.dbpassword.db_password
  kms_key_id  = module.kms.kmskeyid
}

# Create db-securitygroup
module "dbsecuritygroup" {
  source = "./dbsecuritygroup"
  vpc_id = var.vpc_id
}

# Create db-subnetgroup-name
module "dbsubnetgroupname" {
  source        = "./dbsubnetgroupname"
  vpc_id        = var.vpc_id
  db_identifier = var.db_identifier
}

# Create postgres db
module "db" {
  source               = "./db/"
  db_sg_id             = module.dbsecuritygroup.db_sg_id
  db_subnetgroup_name  = module.dbsubnetgroupname.db_subnetgroup_name
  db_identifier        = var.db_identifier
  db_engine            = var.db_engine
  db_engine_version    = var.db_engine_version
  db_instance_class    = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = module.dbpassword.db_password
}
