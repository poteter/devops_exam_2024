import base64
import boto3
import json
import random
import os

def lambda_handler(event, context):
    testing_flag = False
    if testing_flag: 
        print("Event received:", json.dumps(event))
        try:
            # Your logic here
            print("Process completed successfully.")
            return {"statusCode": 200, "body": "Success"}
        except Exception as e:
            print(f"Error: {str(e)}")
            return {"statusCode": 500, "body": "Internal Server Error"}
    else:
        try:
            prompt = event.get('body', '')
            
    
            bedrock_client = boto3.client("bedrock-runtime", region_name="us-east-1")
            s3_client = boto3.client("s3")
            
            model_id = os.getenv('BEDROCK_MODEL_ID')
            bucket_name = os.getenv('S3_BUCKET_NAME')
    
            seed = random.randint(0, 2147483647)
            s3_image_path = f"2/generated_images/titan_{seed}.png"
            
            native_request = {
                "taskType": "TEXT_IMAGE",
                "textToImageParams": {"text": prompt},
                "imageGenerationConfig": {
                    "numberOfImages": 1,
                    "quality": "standard",
                    "cfgScale": 8.0,
                    "height": 1024,
                    "width": 1024,
                    "seed": seed,
                }
            }
    
            response = bedrock_client.invoke_model(modelId=model_id, body=json.dumps(native_request))
            model_response = json.loads(response["body"].read())
            
            base64_image_data = model_response["images"][0]
            image_data = base64.b64decode(base64_image_data)
            s3_client.put_object(Bucket=bucket_name, Key=s3_image_path, Body=image_data)
            
            return {
                'statusCode': 200,
                'body': f'Image successfully uploaded to {bucket_name}/{s3_image_path}'
            }
    
        except bedrock_client.exceptions.ValidationException as e:
            return {
                'statusCode': 400,
                'body': f"Request blocked by content filters: {str(e)}"
            }
        except ValueError as e:
            return {
                'statusCode': 500,
                'body': json.dumps({'error': str(e)})
            }
        except Exception as e:
            return {
                'statusCode': 500,
                'body': json.dumps({'error': f"Unexpected error: {str(e)}"})
            }
