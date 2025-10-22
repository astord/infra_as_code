# Create ZIP file for Lambda deployment
data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/lambda_function.zip"

  source {
    content  = <<EOF
import urllib.request
import os

def lambda_handler(event, context):
    url = os.environ['base_url']
    try:
        response = urllib.request.urlopen(url)
        if response.getcode() != 200:
            raise Exception("The {url} url is not working properly!".format(url=url))
    except Exception as e:
        raise Exception("The {url} url is not working properly!".format(url=url))
EOF
    filename = "monikanova_mon_lambda.py"
  }
}

# IAM role for Lambda
resource "aws_iam_role" "monikanova_mon_lambda_role" {
  name = "monitor_monikanova_com_role"

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
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.monikanova_mon_lambda_role.name
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/monitor_monikanova_com"
  retention_in_days = 30
}

# Lambda function with ZIP file
resource "aws_lambda_function" "monitor_monikanova_com" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "monitor_monikanova_com"
  role             = aws_iam_role.monikanova_mon_lambda_role.arn
  handler          = "monikanova_mon_lambda.lambda_handler"
  runtime          = "python3.11"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      base_url = "https://monikanova.com"
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic_execution,
    aws_cloudwatch_log_group.lambda_logs,
  ]
}

# EventBridge rule for scheduling
resource "aws_cloudwatch_event_rule" "monikanova_mon_lambda_schedule" {
  name                = "monitor_monikanova_com_schedule"
  description         = "Trigger monikanova mon Lambda every 5 minutes"
  schedule_expression = "rate(5 minutes)"
}

# EventBridge target
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.monikanova_mon_lambda_schedule.name
  target_id = "TriggerLambda"
  arn       = aws_lambda_function.monitor_monikanova_com.arn
}

# Lambda permission for EventBridge
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.monitor_monikanova_com.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.monikanova_mon_lambda_schedule.arn
}

# CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "monikanova_com_website_alarm" {
  alarm_name          = "monikanova_com_website_alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "Monitoring monikanova.com web site by lambda"
  datapoints_to_alarm = 2
  alarm_actions       = [aws_sns_topic.monitoring.arn]
  ok_actions          = [aws_sns_topic.monitoring.arn]

  dimensions = {
    FunctionName = aws_lambda_function.monitor_monikanova_com.function_name
  }
}
