# Create the pgdb
resource "aws_db_instance" "gfg-pgdb-1" {
  identifier              = var.DB_IDENTIFIER
  engine                  = var.DB_ENGINE
  engine_version          = var.DB_ENGINE_VERSION
  instance_class          = var.DB_INSTANCE_CLASS
  allocated_storage       = var.DB_ALLOCATED_STORAGE
  storage_encrypted       = false
  name                    = var.DB_NAME
  username                = var.DB_USERNAME
  password                = var.DB_PASSWORD
  kms_key_id = var.KMS_KEY_ID
  vpc_security_group_ids  = var.SECURITYGROUP_ID
  publicly_accessible     = true
  db_subnet_group_name    = var.DB_SUBNETGROUP_NAME
  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false
}

resource "aws_ssm_parameter" "secret" {
  name        = "PGDBSERVER-MASTER-PASSWORD"
  type        = "SecureString"
  value       = var.DB_PASSWORD
}
