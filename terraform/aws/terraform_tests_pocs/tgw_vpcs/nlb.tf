## NLB TODO
#resource "aws_lb" "dnat" {
#  name               = "irl-dnat-nlb"
#  load_balancer_type = "network"
#  internal           = true
#  subnet_mapping {
#    subnet_id            = module.vpc1.private_subnets_map["private_1_a"]
#    private_ipv4_address = "10.${local.vpc1_1_cidr}.1.12"
#  }
#}
#
#resource "aws_lb_target_group" "dnat" {
#  name        = "irl-${local.name}-squid-proxy-tg"
#  protocol    = "TCP"
#  port        = 3128
#  target_type = "ip"
#  vpc_id      = data.aws_vpc.vpc.id
#  health_check {
#    interval = 10
#    protocol = "TCP"
#  }
#  preserve_client_ip = true #f2023050901
#}

#resource "aws_lb_listener" "dnat" {
#  load_balancer_arn = aws_lb.dnat.arn
#  port              = 8443
#  protocol          = "TCP"
#
#  default_action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.squid_proxy.arn
#  }
#}
