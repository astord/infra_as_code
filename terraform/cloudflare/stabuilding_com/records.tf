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

resource "cloudflare_dns_record" "cname_abv" {
  zone_id = cloudflare_zone.stabuilding_com.id
  content = "abv.bg"
  name    = "abv-ab57fda4e34f03f09d1234cb4297.stabuilding.com"
  proxied = false
  type    = "CNAME"
  ttl     = "60"
}

resource "cloudflare_dns_record" "mx_10" {
  zone_id  = cloudflare_zone.stabuilding_com.id
  content  = "appsmx1.abv.bg"
  name     = "stabuilding.com"
  proxied  = false
  type     = "MX"
  priority = "10"
  ttl      = "600"
}

resource "cloudflare_dns_record" "mx_20" {
  zone_id  = cloudflare_zone.stabuilding_com.id
  content  = "appsmx2.abv.bg"
  name     = "stabuilding.com"
  proxied  = false
  type     = "MX"
  priority = "20"
  ttl      = "600"
}

resource "cloudflare_dns_record" "txt_spf" {
  zone_id = cloudflare_zone.stabuilding_com.id
  content = "v=spf1 ip4:194.153.145.0/24 ~all"
  name    = "@"
  proxied = false
  type    = "TXT"
  ttl     = "60"
}
