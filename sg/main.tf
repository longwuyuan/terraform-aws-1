# Use vpc_id as data source to get cidr block
data "aws_vpc" "selected" {
   id = var.vpc_id
 }


resource "aws_security_group" "pgdbsg" {
  name        = "pgdbsg"
  description = "RDS postgres servers"
  vpc_id      = var.vpc_id
 
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

 # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "sg_id" {
  value = aws_security_group.pgdbsg.id
}
