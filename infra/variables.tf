variable "bedrock_region" {
  default = "us-east-1"
}

variable "image_bucket_name" {
  default = "pgr301-couch-explorers"
}

variable "model_id" {
  default = "amazon.titan-image-generator-v1"
}

variable "bucket_path" {
  default = "2/generated_images"
}

variable "region" {
  default = "eu-west-1"
}

variable "sqs_queue_name" {
  default = "candidate_2_bedrock_sqs_queue"
}

variable "lambda_function_name" {
  default = "candidate_2_bedrock_sqs_application"
}

variable "candidate" {
  default = "2"
}