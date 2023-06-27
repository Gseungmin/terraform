resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = "cc-api"
  description = "REST API Gateway for EC2"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method

  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "http://${aws_instance.ec2_instance.public_ip}/{proxy}"
}

resource "aws_api_gateway_deployment" "deploy" {
  depends_on  = [aws_api_gateway_integration.integration]
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = "test"
}
