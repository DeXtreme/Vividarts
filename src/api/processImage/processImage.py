import json
import os
import uuid
import boto3

def lambda_handler(event, context):
    # Extract parameters from the API Gateway request
    request_type = event.get('type')
    file_data = event.get('file')

    # Generate a unique image_id
    image_id = str(uuid.uuid4())

    # Check if the type is greyscale
    if request_type.lower() == 'greyscale':
        # Asynchronously invoke another Lambda function for greyscale processing
        greyscale_function_arn = os.environ.get('GREYSCALE_ARN')
        
        if greyscale_function_arn:
            # Invoke the greyscale Lambda function asynchronously
            invoke_greyscale_lambda(image_id, file_data, greyscale_function_arn)

    # Return a JSON response with the image_id
    response = {
        "image_id": image_id
    }

    return {
        'statusCode': 200,
        'body': json.dumps(response)
    }

def invoke_greyscale_lambda(image_id, file_data, greyscale_function_arn):
    # Invoke the greyscale Lambda function asynchronously
    client = boto3.client('lambda')
    payload = {
        "image_id": image_id,
        "file": file_data
    }

    client.invoke(
        FunctionName=greyscale_function_arn,
        InvocationType='Event',  # Asynchronous invocation
        Payload=json.dumps(payload)
    )