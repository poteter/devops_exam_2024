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

resource "aws_cloudwatch_metric_alarm" "sqs_old_age_alarm" {
  alarm_name                = "SQS_Oldest_Message_Age_Alarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = "60"  
  statistic                 = "Maximum"
  threshold                 = "240"  
  alarm_description         = "Alarm when the oldest message in SQS exceeds 4 minutes."
  dimensions = {
    QueueName = aws_sqs_queue.image_queue.name
  }

  alarm_actions             = [aws_sns_topic.sqs_alarm_topic.arn]
  ok_actions                = [aws_sns_topic.sqs_alarm_topic.arn]
  insufficient_data_actions = []

  treat_missing_data        = "notBreaching"
}
