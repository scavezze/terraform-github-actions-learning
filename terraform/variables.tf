variable "aws_secret_key" {
  description = "AWS Secret key"
  type        = string
}

variable "aws_access_key" {
  description = "AWS Secret key"
  type        = string
}

variable "origin_id" {
  description = "Cloud fronmt origin id"
  type        = string
  default     = "natescavezze_terraform_github_actions_learning_origin_id"
}

variable "bucket_name" {
  default     = "natescavezze-terraform-github-actions-learning"
  description = "The name of the bucket"
}
