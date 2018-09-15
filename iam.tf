# Create the role.
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name               = "${var.function_name}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

# Attach a policy for logs.

data "aws_iam_policy_document" "logs" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
    ]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.function_name}:*",
    ]
  }
}

resource "aws_iam_policy" "logs" {
  name   = "${var.function_name}-logs"
  policy = "${data.aws_iam_policy_document.logs.json}"
}

resource "aws_iam_policy_attachment" "logs" {
  name       = "${var.function_name}-logs"
  roles      = ["${aws_iam_role.lambda.name}"]
  policy_arn = "${aws_iam_policy.logs.arn}"
}

resource "aws_iam_policy_attachment" "additional_policy_attachment" {
  count = "${var.additional_policy_arn != "" ? 1 : 0}"
  name       = "${var.function_name}-additional-policy-attachment"
  roles      = ["${aws_iam_role.lambda.name}"]
  policy_arn = "${var.additional_policy_arn}"
}