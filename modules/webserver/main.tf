# ./modules/webserver/main.tf

# Create keypair using $HOME/.ssh/id_rsa.pub
resource "aws_key_pair" "sshkeypair" {
  key_name   = "sshkey"
  public_key = file(var.sshpubkey)
}

# Create IAM role for webserver
resource "aws_iam_role" "webserverrole" {
  name = "webserverrole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Grant access to KMS key for the above role
resource "aws_kms_grant" "kmsgrant" {
  name = "kmsgrant"
  key_id = var.kms_key_id
  grantee_principal = aws_iam_role.webserverrole.arn
  operations = ["Encrypt", "Decrypt", "GenerateDataKey"]
}

# Attach ReadOnlyAcces policy to the webserverrole created above
resource "aws_iam_role_policy_attachment" "iampolicyattachment" {
  role = aws_iam_role.webserverrole.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Create instance profile for webserver
resource "aws_iam_instance_profile" "webserverprofile" {
  name = "webserverprofile"
  role = aws_iam_role.webserverrole.name
}

# Create the webserver security group
resource "aws_security_group" "webserver" {
  name = "webserver"
  vpc_id = var.vpc_id
  ingress {
    self = true
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    self = true
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow all outbound traffic.
  egress {
    self = true
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create webserver ec2 instance  with above role and put the sshpubkey in it
resource "aws_instance" "webserver" {
  ami = var.awsami[var.region]
  instance_type = "t2.micro"
  key_name = aws_key_pair.sshkeypair.key_name
  iam_instance_profile = aws_iam_instance_profile.webserverprofile.name
  vpc_security_group_ids = [aws_security_group.webserver.id]
  root_block_device {
    delete_on_termination = true
    volume_size = 8
    volume_type = "gp2"
  }
}
