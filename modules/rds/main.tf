# ./modules/rds/main.tf

# Create aws kms key
## Caution - Reruns potentially create lots of keys that can NOT be deleted for at least a week after destroying resource
resource "aws_kms_key" "kmskey" {}

# Create alias for key created above
resource "aws_kms_alias" "kmskeyalias" {
  name          = "alias/kmskeyalias"
  target_key_id = aws_kms_key.kmskey.key_id
}

# Output the key for use by ssm/db/other modules
output "kmskeyid" {
  value = aws_kms_key.kmskey.key_id
}

# Generate random string to create db password secret
resource "random_string" "rstring" {
  length  = 16
  special = false
}

# Store the random string generated as pgdb master password to ssm
resource "aws_ssm_parameter" "pgdbsecret" {
  name   = "pgdbserver-master-password"
  type   = "SecureString"
  value  = random_string.rstring.result
  key_id = aws_kms_key.kmskey.key_id
}

# Use vpc_id as data source to get cidr block for securitygroup ingress
data "aws_vpc" "selected" {
  id = var.vpc_id
}

# Create the pgdb security group
resource "aws_security_group" "pgdbsg" {
  name   = "postgres"
  vpc_id = var.vpc_id
  ingress {
    self        = true
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }
  # Allow all outbound traffic.
  egress {
    self        = true
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Use vpc_id as data source to get subnet-id
data "aws_subnet_ids" "selected" {
  vpc_id = var.vpc_id
}

# Create db-subnet-group
resource "aws_db_subnet_group" "dbsubnetgroup" {
  name       = var.db_identifier
  subnet_ids = data.aws_subnet_ids.selected.ids
}

# Now finally Create the db (default postgres)
resource "aws_db_instance" "pgdbserver" {
  identifier              = var.db_identifier
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  storage_encrypted       = false
  name                    = var.db_name
  username                = var.db_username
  password                = random_string.rstring.result
  vpc_security_group_ids  = [aws_security_group.pgdbsg.id]
  publicly_accessible     = true
  db_subnet_group_name    = aws_db_subnet_group.dbsubnetgroup.id
  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false
}

# Output the endpoint of the RDS instance for use by the webserver
output "rds-endpoint" {
  value = aws_db_instance.pgdbserver.endpoint
}
