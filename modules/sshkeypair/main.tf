# Create keypair using $HOME/.ssh/id_rsa.pub
resource "aws_key_pair" "sshkeypair" {
  key_name   = "sshkey"
  public_key = file(var.sshpubkey)
}

output "sshkeyname" {
  value = aws_key_pair.sshkeypair.key_name
}
