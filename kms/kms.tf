resource "aws_kms_key" "kmskey" {}

resource "aws_kms_alias" "kmskeyalias" {
  name          = "alias/kmskeyalias"
  target_key_id = "${aws_kms_key.kmskey.key_id}"
}

output "kmskeyid" {
  value = "${aws_kms_key.kmskey.key_id}"
}
