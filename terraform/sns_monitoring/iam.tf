resource "aws_iam_user" "send_alerts" { # Credentials are manually created in the console!
  name = "monitoring_user"
  tags = local.tags
}

resource "aws_iam_user_policy" "send_alerts" {
  name = "allow_send_alerts_to_sns"
  user = aws_iam_user.send_alerts.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sns:Publish"],
      "Effect": "Allow",
      "Resource": "${aws_sns_topic.monitoring.arn}"
    }
  ]
}
EOF
}
