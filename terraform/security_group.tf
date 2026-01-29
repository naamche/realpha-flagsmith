resource "aws_security_group" "ec2_security_group" {
  name   = var.ec2_security_group_name
  vpc_id = data.aws_vpc.vpc.id

  ingress {
    from_port   = var.application_port
    to_port     = var.application_port
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.all_addresses]
  }
}
