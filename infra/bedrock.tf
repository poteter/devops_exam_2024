# Local variable to construct the Bedrock model ARN
locals {
  bedrock_model_arn = "arn:aws:bedrock:${var.bedrock_region}::foundation-model/${var.model_id}"
}