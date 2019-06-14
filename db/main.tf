# Create the db (default postgres)
resource "aws_db_instance" "pgdbserver" {
  identifier              = var.db_identifier
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  storage_encrypted       = false
  name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  vpc_security_group_ids  = [var.db_sg_id]
  publicly_accessible     = true
  db_subnet_group_name    = var.db_subnetgroup_name
  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false
}
