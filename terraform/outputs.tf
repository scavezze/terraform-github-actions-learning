output "s3-bucket" {
  value = aws_s3_bucket_website_configuration.natescavezze_terraform_github_actions_learning_website.website_endpoint
}
