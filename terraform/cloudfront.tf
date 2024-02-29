resource "aws_cloudfront_distribution" "natescavezze_terraform_github_actions_learning" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [local.domain]

  origin {
    domain_name = aws_s3_bucket.natescavezze_terraform_github_actions_learning.bucket_regional_domain_name
    origin_id   = var.origin_id
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.origin_id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    forwarded_values {
      query_string = false
      cookies {
        forward = "all"
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.natescavezze_terraform_github_actions_learning_cert.arn
    ssl_support_method  = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  custom_error_response {
    error_code            = 404
    error_caching_min_ttl = 86400
    response_page_path    = "/index.html"
    response_code         = 200
  }
}

resource "aws_acm_certificate" "natescavezze_terraform_github_actions_learning_cert" {
  provider          = aws.use1
  domain_name       = local.domain
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
