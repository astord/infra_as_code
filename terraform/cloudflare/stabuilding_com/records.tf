resource "cloudflare_dns_record" "stabuilding" {
  zone_id = cloudflare_zone.stabuilding_com.id
  comment = "main record"
  content = var.public_ip
  name    = "stabuilding.com"
  proxied = false
  type    = "A"
  ttl     = 600
}
resource "cloudflare_dns_record" "cname_stabuilding" {
  zone_id = cloudflare_zone.stabuilding_com.id
  content = var.public_ip
  name    = "www.stabuilding.com"
  proxied = false
  type    = "A"
  ttl     = "600"
}
#resource "cloudflare_dns_record" "mx_10" {
#  zone_id  = cloudflare_zone.monikanova_com.id
#  content  = "mx1.loading.es."
#  name     = "@"
#  proxied  = false
#  type     = "MX"
#  priority = "10"
#  ttl      = "600"
#}
#resource "cloudflare_dns_record" "mx_20" {
#  zone_id  = cloudflare_zone.monikanova_com.id
#  content  = "mx2.loading.es."
#  name     = "@"
#  proxied  = false
#  type     = "MX"
#  priority = "20"
#  ttl      = "600"
#}
