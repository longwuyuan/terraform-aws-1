# Create ec2 instance and put the sshpubkey in it
resource "aws_instance" "webserver" {
  ami           = var.awsami[var.region]
  instance_type = "t2.micro"
  key_name      = var.sshkeyname
}
