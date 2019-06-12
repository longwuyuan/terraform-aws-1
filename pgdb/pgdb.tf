# Create the pgdb
resource "aws_db_instance" "gfg-pgdb-1" {
  identifier = "gfg-pgdb-1"
  engine = "postgres"
  engine_version = "11.2"
  instance_class = "db.t2.micro"
  allocated_storage = 8
  storage_encrypted = false
  name = "gfgdb"
  username = var.DB_USERNAME
  password = var.DB_PASSWORD
  vpc_security_group_ids = var.SECURITY_GROUP_ID
  publicly_accessible = true
  db_subnet_group_name = var.DB_SUBNET_GROUP_NAME
  backup_retention_period = 0
  skip_final_snapshot = true
  deletion_protection = false
}