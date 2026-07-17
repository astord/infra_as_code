variable "cloudflare_api_token" {
  type = string
}

variable "account_id" {
  type = string
}

variable "public_ip_es" {
  type    = string
  default = "91.146.98.48"
}

variable "public_ip_netlify" {
  type    = string
  default = "75.2.60.5"
}
