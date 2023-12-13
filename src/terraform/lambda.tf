resource "aws_lambda_permission" "get_image" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_image.function_name
  principal     = "apigateway.amazonaws.com"

  depends_on = [aws_lambda_function.get_image]
}

resource "aws_lambda_permission" "process_image" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_image.function_name
  principal     = "apigateway.amazonaws.com"

  depends_on = [aws_lambda_function.process_image]
}

resource "aws_lambda_permission" "greyscale" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.greyscale.function_name
  principal     = "apigateway.amazonaws.com"

  depends_on = [aws_lambda_function.greyscale]
}


resource "aws_lambda_function" "get_image" {
  function_name    = "get_image_function"
  handler          = "getImage.lambda_handler"
  runtime          = "python3.10"
  filename         = "../api/getImage/getImage.zip"
  source_code_hash = filebase64("../api/getImage/getImage.zip")
  environment {
    variables = {
      S3_BUCKET = aws_s3_bucket.results.bucket
    }
  }
  role = aws_iam_role.lambda.arn
}


resource "aws_lambda_function" "process_image" {
  function_name    = "process_image_function"
  handler          = "processImage.lambda_handler"
  runtime          = "python3.10"
  filename         = "../api/processImage/processImage.zip"
  source_code_hash = filebase64("../api/processImage/processImage.zip")
  environment {
    variables = {
      S3_BUCKET = aws_s3_bucket.results.bucket
      GREYSCALE_ARN = aws_lambda_function.greyscale.arn
    }
  }
  role = aws_iam_role.lambda.arn
}


resource "aws_lambda_function" "greyscale" {
  function_name    = "greyscale_function"
  handler          = "Greyscale.lambda_handler"
  runtime          = "python3.10"
  filename         = "../api/Greyscale/Greyscale.zip"
  source_code_hash = filebase64("../api/Greyscale/Greyscale.zip")
  timeout = 60
  environment {
    variables = {
      S3_BUCKET = aws_s3_bucket.results.bucket
    }
  }
  role = aws_iam_role.lambda.arn
}
