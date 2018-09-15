variable "function_name" {
  description = "A unique name for the Lambda function (and related IAM resources)"
  type        = "string"
}

variable "filename" {
  description = "Name of the zip file containing the code for the Lambda function"
  type        = "string"
}

variable "handler" {
  description = "The function entrypoint"
  type        = "string"
  default     = "lambda_handler"
}

variable "memory_size" {
  description = "Amount of memory in MB the Lambda function can use at runtime"
  type        = "string"
  default     = 128
}

variable "runtime" {
  description = "The runtime environment for the Lambda function"
  type        = "string"
  default     = "python2.7"
}

variable "timeout" {
  description = "The amount of time the Lambda function can run in seconds"
  type        = "string"
  default     = 10
}

variable "description" {
  description = "Description of what the Lambda function does"
  type        = "string"
}

variable "rate" {
  description = "Rate for the scheduled CW Event in minutes"
  type        = "string"
  default     = 20
}

variable "additional_policy_arn" {
  description = "Additional IAM policy arn"
  type        = "string"
  default     = ""
}

variable "region" {
  description = "AWS Region"
  type        = "string"
  default     = "eu-west-1"
}

variable "subnet_ids" {
  description = "Subnet IDs for Lambda"
  type        = "list"
  default     = []
}

variable "security_group_ids" {
  description = "Security group IDs"
  type        = "list"
  default     = []
}