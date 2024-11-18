data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../lambda_sqs.py"
  output_path = "${path.module}/lambda_sqs.zip"
}

resource "aws_lambda_function" "lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_sqs.lambda_handler"  
  runtime       = "python3.8"
  timeout       = 30

  filename         = "lambda_sqs.zip"
  source_code_hash = filebase64sha256("lambda_sqs.zip")

  environment {
    variables = {
      BUCKET_NAME   = var.image_bucket_name
      BEDROCK_REGION = var.bedrock_region
      BEDROCK_MODEL_ARN = local.bedrock_model_arn
      BUCKET_PATH = var.bucket_path
    }
  }

  depends_on = [
    aws_iam_policy.lambda_policy
  ]
}

resource "aws_lambda_event_source_mapping" "lambda_sqs" {
  event_source_arn  = aws_sqs_queue.image_queue.arn
  function_name     = aws_lambda_function.lambda.arn
  batch_size        = 5
  enabled           = true
  
  depends_on = [
     aws_lambda_function.lambda,
     aws_sqs_queue.image_queue,
     aws_iam_role_policy_attachment.lambda_policy_attachment,
     aws_sqs_queue_policy.sqs_image_queue_policy
  ]
}

