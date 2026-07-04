resource "aws_instance" "this" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id = var.subnet_id

  key_name = module.keypair.key_name

  vpc_security_group_ids = [
    var.security_group_id
  ]

  iam_instance_profile = var.instance_profile_name

  associate_public_ip_address = true

  tags = {
    Name = "${var.project_name}-${var.environment}-ec2"
  }
}

key_name = var.key_name

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.ec2.id

  cidr_ipv4   = "YOUR_PUBLIC_IP/32"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

cidr_ipv4 = "0.0.0.0/0"