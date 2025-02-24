resource "aws_nat_gateway" "vpc1" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.private_nat.id
  private_ip        = "10.${local.vpc1_1_cidr}.1.11"
  tags              = { Name = "irl-test1-private-NATGW_a" }
}
