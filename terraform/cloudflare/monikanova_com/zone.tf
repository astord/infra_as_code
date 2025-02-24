resource "cloudflare_zone" "monikanova_com" {
  name = "monikanova.com"
  account = {
    id = var.account_id
  }
  type = "full"
}
