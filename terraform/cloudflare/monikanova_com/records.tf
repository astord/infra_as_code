resource "cloudflare_dns_record" "monikanova" {
  zone_id = cloudflare_zone.monikanova_com.id
  comment = "main record"
  content = var.public_ip_netlify
  name    = "monikanova.com"
  proxied = false
  type    = "A"
  ttl     = 600
}
resource "cloudflare_dns_record" "a_ipv4" {
  for_each = toset(["ipv4"])

  zone_id = cloudflare_zone.monikanova_com.id
  content = var.public_ip_netlify
  name    = each.key
  proxied = false
  type    = "A"
  ttl     = "600"
}
resource "cloudflare_dns_record" "mail" {
  for_each = toset(["webmail", "mail"])

  zone_id = cloudflare_zone.monikanova_com.id
  content = var.public_ip_es
  name    = each.key
  proxied = false
  type    = "A"
  ttl     = "600"
}
resource "cloudflare_dns_record" "a_old" {
  for_each = toset(["old"])

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
  for_each = toset(["lists", "autoconfig", "autodiscover", "www"])

  zone_id = cloudflare_zone.monikanova_com.id
  content = "monikanova.netlify.app"
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
# Old loading.es DKIM - commented out for ABV migration
#resource "cloudflare_dns_record" "txt_DKIM1" {
#  zone_id = cloudflare_zone.monikanova_com.id
#  content = "\"v=DKIM1; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAx5t1fv22Wh7bIkMyJpWJ9tIAgkLICKAKBs8zy7I7qQKZhwAfhV6/OVvf90w19QrTnpWY9PPzgZ+4uc6tlraYAN61BYgfkk9/q6oaZbjZiEsshQLbSFlzYDG7mHPySrtmRuBFteqPytNxZ00pMMxEv63YO7ExNrtLtFHBxMGhY3gsleaphluocJZ8JpKpH7UbYzk8Cu0jNnkHQp5elIwUAARCiT60JE/G32/Q//dLKQBYFF3tRl7KbzkamLar1h/nWINlukJwfyVNweuTt8S1JA7jaM6Buh67c3eNu3ZgQGCN7XKIGWGaGJnK5xhTXoQnG8b+2tVyybk6VlQGBL2McQIDAQAB;\"" #TXT must be surrounded with ""
#  name    = "default._domainkey"
#  proxied = false
#  type    = "TXT"
#  ttl     = "600"
#}
#resource "cloudflare_dns_record" "txt_o" {
#  zone_id = cloudflare_zone.monikanova_com.id
#  content = "\"o=-\"" #TXT must be surrounded with ""
#  name    = "_domainkey"
#  proxied = false
#  type    = "TXT"
#  ttl     = "600"
#}
# Old strict DMARC - commented out until ABV DKIM is configured
#resource "cloudflare_dns_record" "txt_DMARC" {
#  zone_id = cloudflare_zone.monikanova_com.id
#  content = "\"v=DMARC1; p=quarantine; adkim=s; aspf=s\"" #TXT must be surrounded with ""
#  name    = "_dmarc"
#  proxied = false
#  type    = "TXT"
#  ttl     = "600"
#}
resource "cloudflare_dns_record" "txt_DMARC" {
  zone_id = cloudflare_zone.monikanova_com.id
  content = "\"v=DMARC1; p=none; adkim=r; aspf=r\""
  name    = "_dmarc"
  proxied = false
  type    = "TXT"
  ttl     = "600"
}
#resource "cloudflare_dns_record" "txt_spf" {
#  zone_id = cloudflare_zone.monikanova_com.id
#  content = "\"v=spf1 include:_spf.loading.es -all\""
#  name    = "@"
#  proxied = false
#  type    = "TXT"
#  ttl     = "600"
#}
resource "cloudflare_dns_record" "txt_spf" {
  zone_id = cloudflare_zone.monikanova_com.id
  content = "\"v=spf1 ip4:194.153.145.0/24 ~all\""
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
#resource "cloudflare_dns_record" "mx_30" {
#  zone_id  = cloudflare_zone.monikanova_com.id
#  content  = "mx3.loading.es."
#  name     = "@"
#  proxied  = false
#  type     = "MX"
#  priority = "30"
#  ttl      = "600"
#}
resource "cloudflare_dns_record" "mx_10" {
  zone_id  = cloudflare_zone.monikanova_com.id
  content  = "appsmx1.abv.bg"
  name     = "@"
  proxied  = false
  type     = "MX"
  priority = "10"
  ttl      = "600"
}
resource "cloudflare_dns_record" "mx_20" {
  zone_id  = cloudflare_zone.monikanova_com.id
  content  = "appsmx2.abv.bg"
  name     = "@"
  proxied  = false
  type     = "MX"
  priority = "20"
  ttl      = "600"
}
resource "cloudflare_dns_record" "cname_abv_mail_monikanova" {
  zone_id = cloudflare_zone.monikanova_com.id
  content = "abv.bg"
  name    = "abv-765fdfb078daebae417d84701536.monikanova.com"
  proxied = false
  type    = "CNAME"
  ttl     = "600"
}
resource "cloudflare_dns_record" "admin_monikanova" {
  zone_id = cloudflare_zone.monikanova_com.id
  comment = "admin record"
  content = var.public_ip_bg
  name    = "admin.monikanova.com"
  proxied = false
  type    = "A"
  ttl     = 300
}

# systeme.io - escuela.monikanova.com site (CloudFront) and its ACM certificate validation.
# Must stay DNS only (proxied = false), otherwise ACM validation and CloudFront TLS break.
resource "cloudflare_dns_record" "cname_systeme_escuela" {
  zone_id = cloudflare_zone.monikanova_com.id
  comment = "systeme.io escuela site"
  content = "d3ufwxza5ccfum.cloudfront.net"
  name    = "escuela"
  proxied = false
  type    = "CNAME"
  ttl     = 600
}
resource "cloudflare_dns_record" "cname_systeme_escuela_acm" {
  zone_id = cloudflare_zone.monikanova_com.id
  comment = "systeme.io escuela ACM certificate validation"
  content = "_1bb9f03a605fdffd927067e8496b4d7e.wzccmgtwzk.acm-validations.aws"
  name    = "_077cb6a25fa9ca37ea91e0e06a251365.escuela"
  proxied = false
  type    = "CNAME"
  ttl     = 600
}

# systeme.io - email sending authentication for @monikanova.com
# si<id> = return-path (SPF + bounces), systemeio1/2 = DKIM keys hosted by systeme.io
resource "cloudflare_dns_record" "cname_systeme_return_path" {
  zone_id = cloudflare_zone.monikanova_com.id
  comment = "systeme.io return-path (SPF + bounces)"
  content = "inbound.systeme.io"
  name    = "si19252158"
  proxied = false
  type    = "CNAME"
  ttl     = 600
}
resource "cloudflare_dns_record" "cname_systeme_dkim" {
  for_each = {
    "systemeio1._domainkey" = "key1.systeme.io"
    "systemeio2._domainkey" = "key2.systeme.io"
  }

  zone_id = cloudflare_zone.monikanova_com.id
  comment = "systeme.io DKIM"
  content = each.value
  name    = each.key
  proxied = false
  type    = "CNAME"
  ttl     = 600
}
