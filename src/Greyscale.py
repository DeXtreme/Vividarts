import os
import json
import boto3
from PIL import Image
from io import BytesIO

def lambda_handler(event, context):
    # Extract parameters from the Lambda event
    image_id = event.get('image_id')
    file_data = event.get('file')

    # Check if the required parameters are present
    if not image_id or not file_data:
        return {
            'statusCode': 400,
            'body': json.dumps('Missing required parameters: image_id and file')
        }

    # Load the image from base64-encoded data
    image = Image.open(BytesIO(file_data))

    # Convert the image to greyscale
    greyscale_image = image.convert('L')

    # Save the greyscale image to S3
    s3_bucket = os.environ.get('S3_BUCKET')

    if s3_bucket:
        s3_key = f"{image_id}.png"  # Adjust the file format as needed
        save_to_s3(greyscale_image, s3_bucket, s3_key)

        return {
            'statusCode': 200,
            'body': json.dumps(f'File saved to S3 bucket: s3://{s3_bucket}/{s3_key}')
        }
    else:
        return {
            'statusCode': 500,
            'body': json.dumps('S3_BUCKET environment variable not set')
        }

def save_to_s3(image, bucket, key):
    # Save the image to S3
    s3 = boto3.client('s3')

    # Save the image to a BytesIO object
    output_buffer = BytesIO()
    image.save(output_buffer, format='PNG')  # Adjust the format as needed
    output_buffer.seek(0)

    # Upload the image to S3
    s3.upload_fileobj(output_buffer, bucket, key)