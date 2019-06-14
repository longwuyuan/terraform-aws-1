resource "random_string" "dbpassword" {
  length  = 16
  special = false
}

output "db_password" {
  value = random_string.dbpassword.result
}
