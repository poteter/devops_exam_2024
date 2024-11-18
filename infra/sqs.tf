resource "aws_sqs_queue" "image_queue" {
  name                       = var.sqs_queue_name
  visibility_timeout_seconds = 60
}

resource "aws_sns_topic" "sqs_alarm_topic" {
  name = "sqs-alarm-notifications"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.sqs_alarm_topic.arn
  protocol  = "email"
  endpoint  = "thoeiv15@student.kristiania.no"
}