resource "aws_ec2_transit_gateway" "irl" {
  description                     = "IRL TGW Test"
  amazon_side_asn                 = "65534"
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  tags                            = { "Name" = "IRL TGW Test" }
}
