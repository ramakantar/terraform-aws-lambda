resource "aws_cloudwatch_event_rule" "schedule" {
  name        = "${var.function_name}-schedule"
  description = "Runs ${var.function_name} every ${var.rate} minutes"

  schedule_expression = "rate(${var.rate} minutes)"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.lambda.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.schedule.arn}"
}