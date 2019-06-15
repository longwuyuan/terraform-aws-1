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

# Create webserver ec2 instance  with above role and put the sshpubkey in it
resource "aws_instance" "webserver" {
  ami = var.awsami[var.region]
  instance_type = "t2.micro"
  key_name = var.sshkeyname
  iam_instance_profile = aws_iam_instance_profile.webserverprofile.name
  root_block_device {
    delete_on_termination = true
    volume_size = 8
    volume_type = "gp2"
  }
}
