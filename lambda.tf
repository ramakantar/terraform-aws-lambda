resource "aws_lambda_function" "lambda" {

  function_name                  = "${var.function_name}"
  filename                       = "${var.filename}"
  description                    = "${var.description}"
  role                           = "${aws_iam_role.lambda.arn}"
  handler                        = "${var.function_name}.${var.handler}"
  memory_size                    = "${var.memory_size}"
  runtime                        = "${var.runtime}"
  timeout                        = "${var.timeout}"
  source_code_hash = "${base64sha256(file(var.filename))}"
  vpc_config {
    subnet_ids = [ "${var.subnet_ids}" ]
    security_group_ids = [ "${var.security_group_ids}" ]
  }
}