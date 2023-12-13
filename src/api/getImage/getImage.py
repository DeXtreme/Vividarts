import os
import json
import boto3
from botocore.exceptions import ClientError

def lambda_handler(event, context):

    headers = {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Content-Type",
        "Access-Control-Allow-Methods": "OPTIONS,GET",
    }

    # Check if the request is a preflight request (OPTIONS)
    if event["httpMethod"] == "OPTIONS":
        return {
            "statusCode": 200,
            "headers": headers,
            "body": "Preflight request successful",
        }
    
    # Extract the image_id from the path parameter
    image_id = event.get('pathParameters', {}).get('image_id')

    # Check if the required parameter is present
    if not image_id:
        return {
            'statusCode': 400,
            "headers": headers,
            'body': json.dumps('Missing required parameter: image_id')
        }

    # Retrieve the S3 bucket name from the environment variable
    s3_bucket = os.environ.get('S3_BUCKET')

    if not s3_bucket:
        return {
            'statusCode': 500,
            "headers": headers,
            'body': json.dumps('S3_BUCKET environment variable not set')
        }

    # Generate a presigned URL for the image in S3
    try:
        s3_client = boto3.client('s3')
        s3_client.head_object(Bucket=s3_bucket, Key=f'{image_id}.jpg')
        presigned_url = generate_presigned_url(s3_client, s3_bucket, f'{image_id}.jpg')

        # Return a JSON response with the presigned URL
        response = {
            'url': presigned_url
        }

        return {
            'statusCode': 200,
            "headers": headers,
            'body': json.dumps(response)
        }

    except ClientError as e:
        return {
            'statusCode': 500,
            "headers": headers,
            'body': json.dumps(f'Error generating presigned URL: {str(e)}')
        }

def generate_presigned_url(s3_client, bucket, key, expiration=3600):
    # Generate a presigned URL for the S3 object
    url = s3_client.generate_presigned_url(
        'get_object',
        Params={'Bucket': bucket, 'Key': key},
        ExpiresIn=expiration
    )
    return url