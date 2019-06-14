# Use vpc_id as data source to get subnet-id
data "aws_subnet_ids" "selected" {
  vpc_id = var.vpc_id
}

# Create db-subnet-group
resource "aws_db_subnet_group" "dbsubnetgroup" {
  name       = var.db_identifier
  subnet_ids = data.aws_subnet_ids.selected.ids
}

output "db_subnetgroup_name" {
  value = aws_db_subnet_group.dbsubnetgroup.id
}
