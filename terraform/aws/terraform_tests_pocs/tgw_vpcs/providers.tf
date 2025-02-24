provider "aws" {
  profile = "emp_jungle"
  region  = local.aws_region

  default_tags {
    tags = local.default_tags
  }
}
