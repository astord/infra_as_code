resource "aws_sns_topic" "monitoring" {
  name = "eu_central_1_monitoring_notifications"
  tags = local.tags
}

resource "aws_sns_topic_subscription" "monitoring" {
  topic_arn              = aws_sns_topic.monitoring.arn
  protocol               = "email"
  endpoint               = local.deyan_mail
  endpoint_auto_confirms = true
}

