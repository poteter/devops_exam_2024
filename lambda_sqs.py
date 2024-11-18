import base64
import boto3
import json
import random
import os

# Frank; This is probalby be closer to what we need in production. Let's get funding first!

bedrock_client = boto3.client("bedrock-runtime", region_name="us-east-1")
s3_client = boto3.client("s3")

MODEL_ID = os.environ["BEDROCK_MODEL_ARN"]
BUCKET_NAME =  os.environ["BUCKET_NAME"]
s3_image_path = os.environ["BUCKET_PATH"]

def lambda_handler(event, context):
    # Loop through all SQS records in the event
    for record in event["Records"]:
        # Extract the SQS message body
        prompt = record["body"]
        seed = random.randint(0, 2147483647)
        # Prepare the request for image generation
        native_request = {
            "taskType": "TEXT_IMAGE",
            "textToImageParams": {"text": prompt},
            "imageGenerationConfig": {
                "numberOfImages": 1,
                "quality": "standard",
                "cfgScale": 8.0,
                "height": 512,
                "width": 512,
                "seed": seed,
            },
        }

        # Invoke the model
        response = bedrock_client.invoke_model(
            modelId=MODEL_ID,
            body=json.dumps(native_request)
        )

        model_response = json.loads(response["body"].read())
        base64_image_data = model_response["images"][0]
        image_data = base64.b64decode(base64_image_data)
        
        # Generate a unique image filename
        image_filename = f"titan_{seed}.png"
        
        # Construct the full S3 key
        s3_image_key = f"{s3_image_path}/{image_filename}"

        # Upload the image to S3
        s3_client.put_object(Bucket=BUCKET_NAME, Key=s3_image_key, Body=image_data)

    return {
        "statusCode": 200,
        "body": json.dumps("")
    }
