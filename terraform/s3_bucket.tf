resource "aws_s3_bucket" "natescavezze_terraform_github_actions_learning" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "natescavezze_terraform_github_actions_learning_acl" {
  bucket     = aws_s3_bucket.natescavezze_terraform_github_actions_learning.id
  acl        = "public-read"
  depends_on = [aws_s3_bucket_ownership_controls.natescavezze_terraform_github_actions_learning_ownership]
}

resource "aws_s3_bucket_policy" "natescavezze_terraform_github_actions_learning_policy" {
  bucket     = aws_s3_bucket.natescavezze_terraform_github_actions_learning.id
  policy     = data.aws_iam_policy_document.s3_website_policy.json
  depends_on = [aws_s3_bucket_ownership_controls.natescavezze_terraform_github_actions_learning_ownership]
}

resource "aws_s3_bucket_ownership_controls" "natescavezze_terraform_github_actions_learning_ownership" {
  bucket = aws_s3_bucket.natescavezze_terraform_github_actions_learning.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.natescavezze_terraform_github_actions_learning_acc_block]
}

resource "aws_s3_bucket_public_access_block" "natescavezze_terraform_github_actions_learning_acc_block" {
  bucket = aws_s3_bucket.natescavezze_terraform_github_actions_learning.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "natescavezze_terraform_github_actions_learning_website" {
  bucket = aws_s3_bucket.natescavezze_terraform_github_actions_learning.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_object" "uplaodstuff" {
  bucket   = aws_s3_bucket.natescavezze_terraform_github_actions_learning.id
  for_each = fileset("../dist/", "**/*.*")

  key          = each.value
  source       = "../dist/${each.value}"
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", "${each.value}"), null)
}
