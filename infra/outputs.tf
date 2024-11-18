output "sqs_queue_url" {
  value = aws_sqs_queue.image_queue.id
}

output "sqs_queue_arn" {
  value = aws_sqs_queue.image_queue.arn
}

output "account_id" {
  description = "The AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "bedrock_model_arn" {
  description = "The ARN of the Bedrock model."
  value       = local.bedrock_model_arn
}