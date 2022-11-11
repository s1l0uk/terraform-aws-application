module "vpc_lambda_function" {
  source = "terraform-aws-modules/lambda/aws"
  count  = length(var.code_sources)

  function_name = var.name
  description   = "lambda function for ${var.name} - ${var.code_sources[count.index]}"
  handler       = var.entry_point
  runtime       = var.language
  publish = true

  source_path = var.code_sources[count.index]
  environment_variables = var.environment_variables

  vpc_subnet_ids         = var.subnet_ids
  vpc_security_group_ids = var.security_group_ids
  attach_network_policy  = true
  allowed_triggers = {
    OneRule = {
      principal  = "events.amazonaws.com"
      source_arn = aws_cloudwatch_event_rule.every_day.arn
    }
  }
}

resource "aws_cloudwatch_event_rule" "every_day" {
  name                = "every-day-run"
  description         = "Fires every day"
  schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "everyday" {
    rule = aws_cloudwatch_event_rule.every_day.name
    target_id = "every-day-run"
    arn = module.vpc_lambda_function[0].lambda_function_arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = module.vpc_lambda_function[0].lambda_function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.every_day.arn
}
