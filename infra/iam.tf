data "aws_caller_identity" "current" {}

resource "aws_iam_role" "lambda_role" {
  name = "candidate_${var.candidate}_LambdaBedrockRole"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "candidate_${var.candidate}_LambdaBedrockPolicy"
  description = "Permissions for Lambda to access Bedrock and S3, and write logs"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowBedrockModelInvocation",
        "Effect": "Allow",
        "Action": "bedrock:InvokeModel",
        "Resource": local.bedrock_model_arn
      },
      {
        "Sid": "AllowS3PutObject",
        "Effect": "Allow",
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::${data.aws_s3_bucket.image_bucket.id}/2/generated_images/*"
      },
      {
        "Sid": "AllowSQSPermissions",
        "Effect": "Allow",
        "Action": [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:ChangeMessageVisibility"
        ],
        "Resource": aws_sqs_queue.image_queue.arn
      },
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_sqs_queue_policy" "sqs_image_queue_policy" {
  queue_url = aws_sqs_queue.image_queue.id

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "QueuePolicy",
    Statement = [
      {
        Sid       = "AllowLambdaService",
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action    = "sqs:SendMessage",
        Resource  = aws_sqs_queue.image_queue.arn
      }
    ]
  })
}