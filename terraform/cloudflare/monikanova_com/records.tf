resource "cloudflare_dns_record" "monikanova" {
  zone_id = cloudflare_zone.monikanova_com.id
  comment = "main record"
  content = var.public_ip_bg
  name    = "monikanova.com"
  proxied = false
  type    = "A"
  ttl     = 600
}
resource "cloudflare_dns_record" "a_ipv4" {
  for_each = toset(["webmail", "ipv4", "mail"])

  zone_id = cloudflare_zone.monikanova_com.id
  content = var.public_ip_es
  name    = each.key
  proxied = false
  type    = "A"
  ttl     = "600"
}
resource "cloudflare_dns_record" "a_ipv6" {
  for_each = toset(["webmail", "ipv6", "mail"])

  zone_id = cloudflare_zone.monikanova_com.id
  content = "2a01:71c0:3:1:118::f"
  name    = each.key
  proxied = false
  type    = "AAAA"
  ttl     = "600"
}
resource "cloudflare_dns_record" "cname_monikanova" {
  for_each = toset(["lists", "autoconfig", "autodiscover", "www", "ftp"])

  zone_id = cloudflare_zone.monikanova_com.id
  content = "monikanova.com"
  name    = each.key
  proxied = false
  type    = "CNAME"
  ttl     = "600"
}
resource "cloudflare_dns_record" "cname_mail_monikanova" {
  for_each = toset(["smtp", "pop"])

  zone_id = cloudflare_zone.monikanova_com.id
  content = "mail.monikanova.com"
  name    = each.key
  proxied = false
  type    = "CNAME"
  ttl     = "600"
}
resource "cloudflare_dns_record" "txt_DKIM1" {
  zone_id = cloudflare_zone.monikanova_com.id
  content = "\"v=DKIM1; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAx5t1fv22Wh7bIkMyJpWJ9tIAgkLICKAKBs8zy7I7qQKZhwAfhV6/OVvf90w19QrTnpWY9PPzgZ+4uc6tlraYAN61BYgfkk9/q6oaZbjZiEsshQLbSFlzYDG7mHPySrtmRuBFteqPytNxZ00pMMxEv63YO7ExNrtLtFHBxMGhY3gsleaphluocJZ8JpKpH7UbYzk8Cu0jNnkHQp5elIwUAARCiT60JE/G32/Q//dLKQBYFF3tRl7KbzkamLar1h/nWINlukJwfyVNweuTt8S1JA7jaM6Buh67c3eNu3ZgQGCN7XKIGWGaGJnK5xhTXoQnG8b+2tVyybk6VlQGBL2McQIDAQAB;\"" #TXT must be surrounded with ""
  name    = "default._domainkey"
  proxied = false
  type    = "TXT"
  ttl     = "600"
}
resource "cloudflare_dns_record" "txt_o" {
  zone_id = cloudflare_zone.monikanova_com.id
  content = "\"o=-\"" #TXT must be surrounded with ""
  name    = "_domainkey"
  proxied = false
  type    = "TXT"
  ttl     = "600"
}
resource "cloudflare_dns_record" "txt_DMARC" {
  zone_id = cloudflare_zone.monikanova_com.id
  content = "\"v=DMARC1; p=quarantine; adkim=s; aspf=s\"" #TXT must be surrounded with ""
  name    = "_dmarc"
  proxied = false
  type    = "TXT"
  ttl     = "600"
}
resource "cloudflare_dns_record" "txt_spf" {
  zone_id = cloudflare_zone.monikanova_com.id
  content = "\"v=spf1 include:_spf.loading.es -all\""
  name    = "@"
  proxied = false
  type    = "TXT"
  ttl     = "600"
}
resource "cloudflare_dns_record" "txt_google" {
  zone_id = cloudflare_zone.monikanova_com.id
  content = "\"google-site-verification=l5L3hTNfoaApXXT4S--veOsB-_9ZZ7ECmktQsprg8Zg\""
  name    = "@"
  proxied = false
  type    = "TXT"
  ttl     = "600"
}
resource "cloudflare_dns_record" "mx_10" {
  zone_id  = cloudflare_zone.monikanova_com.id
  content  = "mx1.loading.es."
  name     = "@"
  proxied  = false
  type     = "MX"
  priority = "10"
  ttl      = "600"
}
resource "cloudflare_dns_record" "mx_20" {
  zone_id  = cloudflare_zone.monikanova_com.id
  content  = "mx2.loading.es."
  name     = "@"
  proxied  = false
  type     = "MX"
  priority = "20"
  ttl      = "600"
}
resource "cloudflare_dns_record" "mx_30" {
  zone_id  = cloudflare_zone.monikanova_com.id
  content  = "mx3.loading.es."
  name     = "@"
  proxied  = false
  type     = "MX"
  priority = "30"
  ttl      = "600"
}
