# Store the pgdb master password to ssm
resource "aws_ssm_parameter" "secret" {
  name   = "pgdbserver-master-password"
  type   = "SecureString"
  value  = var.db_password
  key_id = var.kms_key_id
}
