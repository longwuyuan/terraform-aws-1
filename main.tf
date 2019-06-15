provider "aws" {
  region = var.region
}

# Create rds postgres db
module "rds" {
  source               = "./modules/rds/"
  vpc_id               = var.vpc_id
  db_identifier        = var.db_identifier
  db_engine            = var.db_engine
  db_engine_version    = var.db_engine_version
  db_instance_class    = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_name              = var.db_name
  db_username          = var.db_username
}

# Create ec2-instance for webserver
module "webserver" {
  source    = "./modules/webserver"
  region    = var.region
  awsami    = var.awsami
}
