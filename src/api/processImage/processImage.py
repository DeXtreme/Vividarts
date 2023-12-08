import json
import os
import uuid
import boto3
import base64
from io import BytesIO

def lambda_handler(event, context):
    headers = {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Content-Type",
        "Access-Control-Allow-Methods": "OPTIONS,POST",
    }

    # Check if the request is a preflight request (OPTIONS)
    if event["httpMethod"] == "OPTIONS":
        return {
            "statusCode": 200,
            "headers": headers,
            "body": "Preflight request successful",
        }
    
    # Extract parameters from the API Gateway request
    body = json.loads(event.get("body"))
    request_type = body.get('type')
    file_data = body.get('file')

    # Generate a unique image_id
    result_image_id = str(uuid.uuid4())
    image_id = str(uuid.uuid4())

    # Save the image to S3
    s3 = boto3.client('s3')
    s3_bucket = os.environ.get('S3_BUCKET')
    image = BytesIO(base64.b64decode(file_data))
    s3.upload_fileobj(image, s3_bucket, f"{image_id}.jpg")

    # Check if the type is greyscale
    if request_type.lower() == 'greyscale':
        # Asynchronously invoke another Lambda function for greyscale processing
        greyscale_function_arn = os.environ.get('GREYSCALE_ARN')
        
        if greyscale_function_arn:
            # Invoke the greyscale Lambda function asynchronously
            invoke_greyscale_lambda(image_id,result_image_id,greyscale_function_arn)

    # Return a JSON response with the image_id
    response = {
        "image_id": result_image_id
    }

    return {
        'statusCode': 200,
        "headers": headers,
        'body': json.dumps(response)
    }

def invoke_greyscale_lambda(image_id, result_image_id, greyscale_function_arn):
    # Invoke the greyscale Lambda function asynchronously
    client = boto3.client('lambda')
    payload = {
        "image_id": image_id,
        "result_image_id": result_image_id,
    }

    client.invoke(
        FunctionName=greyscale_function_arn,
        InvocationType='Event',  # Asynchronous invocation
        Payload=json.dumps(payload)
    )