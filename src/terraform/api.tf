resource "aws_api_gateway_rest_api" "api" {
  name        = "vividarts-api"
  description = "Vividarts api"
}

resource "aws_api_gateway_resource" "get_image_parent" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "getImage"
}

resource "aws_api_gateway_resource" "get_image" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.get_image_parent.id
  path_part   = "{image_id}"
}

resource "aws_api_gateway_method" "get_image_get" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.get_image.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "get_image_options" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.get_image.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_image_get" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.get_image.id
  http_method             = aws_api_gateway_method.get_image_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get_image.invoke_arn
}

resource "aws_api_gateway_integration" "get_image_options" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.get_image.id
  http_method             = aws_api_gateway_method.get_image_options.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get_image.invoke_arn
}

// Resources for the process_image api resource
resource "aws_api_gateway_resource" "process_image" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "processImage"
}


resource "aws_api_gateway_method" "process_image_post" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.process_image.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "process_image_options" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.process_image.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "process_image_post" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.process_image.id
  http_method             = aws_api_gateway_method.process_image_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.process_image.invoke_arn
}

resource "aws_api_gateway_integration" "process_image_options" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.process_image.id
  http_method             = aws_api_gateway_method.process_image_options.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.process_image.invoke_arn
}

resource "aws_api_gateway_stage" "api" {
  stage_name = "api"
  rest_api_id = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.api.id
}

resource "aws_api_gateway_deployment" "api" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  depends_on = [ 
    aws_api_gateway_integration.get_image_get,
    aws_api_gateway_integration.get_image_options,
    aws_api_gateway_integration.process_image_options,
    aws_api_gateway_integration.process_image_post  
  ]  
}
