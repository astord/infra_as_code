# VPC1
module "vpc1" {
  source = "git::ssh://git@emp-sof-github01.emp.internal.com/eMerchantPay/terraform_vpc.git"

  vpc_cidr_block         = "10.${local.vpc1_cidr}.0.0/16"
  secondary_cidr_blocks  = ["10.${local.vpc1_1_cidr}.0.0/16"]
  aws_region             = local.aws_region
  vpc_availability_zones = ["a", "b"]
  name                   = "irl-test1"
  vpc_domain_name        = "emp.local"
  vpc_public_subnets_natgw = {
    public_NATGW_a = {
      az      = "a",
      network = "10.${local.vpc1_cidr}.0.0/25",
    }
    public_NATGW_b = {
      az      = "b",
      network = "10.${local.vpc1_cidr}.0.128/25",
    }
  }
  vpc_private_subnets = {
    private_a = {
      az      = "a",
      network = "10.${local.vpc1_cidr}.1.0/24",
    }
    private_b = {
      az      = "b"
      network = "10.${local.vpc1_cidr}.2.0/24",
    }
    #private_1_a = {
    #  az      = "a",
    #  network = "10.${local.vpc1_1_cidr}.1.0/24",
    #}
  }
  vpc_flow_logs_params = { enable_vpc_logs = false }
}

#VPC1 NAT Subnet
resource "aws_subnet" "private_nat" {
  vpc_id     = module.vpc1.vpc_id
  cidr_block = "10.${local.vpc1_1_cidr}.1.0/24"

  tags = {
    Name = "private_nat"
  }
}

resource "aws_route_table" "private_nat" {
  vpc_id = module.vpc1.vpc_id
  tags   = { "Name" = "private_nat" }
}

resource "aws_route_table_association" "private_nat" {
  subnet_id      = aws_subnet.private_nat.id
  route_table_id = aws_route_table.private_nat.id
}

resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private_nat.id
  destination_cidr_block = "10.${local.vpc2_cidr}.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.irl.id
}

resource "aws_route" "aws_vpc1_routes_via_nat_gw" {
  route_table_id         = module.vpc1.vpc_private_route_tables_map["a"]
  destination_cidr_block = "10.${local.vpc2_cidr}.0.0/16"
  nat_gateway_id         = aws_nat_gateway.vpc1.id
}

# VPC2
module "vpc2" {
  source = "git::ssh://git@emp-sof-github01.emp.internal.com/eMerchantPay/terraform_vpc.git"

  vpc_cidr_block         = "10.${local.vpc2_cidr}.0.0/16"
  aws_region             = local.aws_region
  vpc_availability_zones = ["a", "b"]
  name                   = "irl-test2"
  vpc_domain_name        = "emp.local"
  vpc_public_subnets_natgw = {
    public_NATGW_a = {
      az      = "a",
      network = "10.${local.vpc2_cidr}.0.0/25",
    }
    public_NATGW_b = {
      az      = "b",
      network = "10.${local.vpc2_cidr}.0.128/25",
    }
  }
  vpc_private_subnets = {
    private_a = {
      az      = "a",
      network = "10.${local.vpc2_cidr}.1.0/24",
    }
    private_b = {
      az      = "b"
      network = "10.${local.vpc2_cidr}.2.0/24",
    }
  }
  vpc_flow_logs_params = { enable_vpc_logs = false }
}

resource "aws_route" "aws_vpc2_routes_via_tgw" {

  # Combining subnets with route-tables keys to produce a single unique key per instance.
  # Creating a nested map to be able to loop over it.
  for_each = {
    for pair in setproduct(["10.${local.vpc1_1_cidr}.0.0/16"], values(module.vpc2.vpc_private_route_tables_map)) :
    "${pair[0]}.${pair[1]}" => { subnet = pair[0], table = pair[1] }
  }
  route_table_id         = each.value["table"]
  destination_cidr_block = each.value["subnet"]
  transit_gateway_id     = aws_ec2_transit_gateway.irl.id
}

#TGW attachments
resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1" {
  subnet_ids = [
    module.vpc1.public_subnets_natgw_map["public_NATGW_a"],
    module.vpc1.public_subnets_natgw_map["public_NATGW_b"],
  ]
  transit_gateway_id = aws_ec2_transit_gateway.irl.id
  vpc_id             = module.vpc1.vpc_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc2" {
  subnet_ids = [
    module.vpc2.public_subnets_natgw_map["public_NATGW_a"],
    module.vpc2.public_subnets_natgw_map["public_NATGW_b"],
  ]
  transit_gateway_id = aws_ec2_transit_gateway.irl.id
  vpc_id             = module.vpc2.vpc_id
}
