# Websites monitored by a Lambda (expects HTTP 200).
# To monitor a new site add its domain to local.monitored_websites.
locals {
  monitored_websites = ["monikanova.com", "stabuilding.com"]

  websites = { for domain in local.monitored_websites : replace(domain, ".", "_") => domain }
}

# Create ZIP file for Lambda deployment (shared by all websites)
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/website_mon_lambda.py"
  output_path = "${path.module}/lambda_function.zip"
}

# IAM role for Lambda
resource "aws_iam_role" "website_mon" {
  for_each = local.websites
  name     = "monitor_${each.key}_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# IAM policy attachment for basic Lambda execution
resource "aws_iam_role_policy_attachment" "website_mon" {
  for_each   = local.websites
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.website_mon[each.key].name
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "website_mon" {
  for_each          = local.websites
  name              = "/aws/lambda/monitor_${each.key}"
  retention_in_days = 30
}

# Lambda function with ZIP file
resource "aws_lambda_function" "website_mon" {
  for_each         = local.websites
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "monitor_${each.key}"
  role             = aws_iam_role.website_mon[each.key].arn
  handler          = "website_mon_lambda.lambda_handler"
  runtime          = "python3.11"
  timeout          = 30
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      base_url = "https://${each.value}"
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.website_mon,
    aws_cloudwatch_log_group.website_mon,
  ]
}

# EventBridge rule for scheduling
resource "aws_cloudwatch_event_rule" "website_mon" {
  for_each            = local.websites
  name                = "monitor_${each.key}_schedule"
  description         = "Trigger monitor_${each.key} Lambda every 5 minutes"
  schedule_expression = "rate(5 minutes)"
}

# EventBridge target
resource "aws_cloudwatch_event_target" "website_mon" {
  for_each  = local.websites
  rule      = aws_cloudwatch_event_rule.website_mon[each.key].name
  target_id = "TriggerLambda"
  arn       = aws_lambda_function.website_mon[each.key].arn
}

# Lambda permission for EventBridge
resource "aws_lambda_permission" "website_mon" {
  for_each      = local.websites
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.website_mon[each.key].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.website_mon[each.key].arn
}

# CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "website_mon" {
  for_each            = local.websites
  alarm_name          = "${each.key}_website_alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "Monitoring ${each.value} web site by lambda"
  datapoints_to_alarm = 2
  alarm_actions       = [aws_sns_topic.monitoring.arn]
  ok_actions          = [aws_sns_topic.monitoring.arn]

  dimensions = {
    FunctionName = aws_lambda_function.website_mon[each.key].function_name
  }
}
