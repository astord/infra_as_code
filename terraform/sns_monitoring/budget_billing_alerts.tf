resource "aws_budgets_budget" "monthly_budget" {
  name              = "Monthly-limit"
  budget_type       = "COST"
  limit_amount      = "5.0"
  limit_unit        = "USD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2020-01-01_00:00"
  time_unit         = "MONTHLY"
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80 #%
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [local.deyan_mail]
  }
}
