resource "cloudflare_zone" "stabuilding_com" {
  name = "stabuilding.com"
  account = {
    id = var.account_id
  }
  type = "full"
}
