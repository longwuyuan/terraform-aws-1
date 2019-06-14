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
