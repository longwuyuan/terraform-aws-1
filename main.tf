# ./main.tf

# Provider is aws
provider "aws" {
  region = var.region
}

# Create aws kms key
## Caution - Reruns potentially create lots of keys that can NOT be deleted     for at least a week after destroying resource
resource "aws_kms_key" "kmskey" {}

# Create alias for key created above
resource "aws_kms_alias" "kmskeyalias" {
  name          = "alias/kmskeyalias"
  target_key_id = aws_kms_key.kmskey.key_id
}

# Create rds postgres db
module "rds" {
  source               = "./modules/rds/"
  vpc_id               = var.vpc_id
  kms_key_id           = aws_kms_key.kmskey.key_id
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
  source     = "./modules/webserver"
  kms_key_id = aws_kms_key.kmskey.key_id
  region     = var.region
  vpc_id     = var.vpc_id
  awsami     = var.awsami
  rds_endpoint = module.rds.rds_endpoint
}
