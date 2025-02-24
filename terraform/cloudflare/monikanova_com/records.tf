resource "cloudflare_dns_record" "www" {
  zone_id = cloudflare_zone.monikanova_com.id
  comment = "verification record"
  content = var.public_ip
  name    = "www"
  proxied = false
  type    = "A"
  ttl     = 3600
}
