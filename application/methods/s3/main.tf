resource "aws_s3_bucket_website_configuration" "www_bucket" {
  bucket = "www.${var.name}"

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }

}

# S3 bucket for redirecting non-www to www.
resource "aws_s3_bucket_website_configuration" "root_bucket" {
  bucket = var.name

  routing_rule {
    condition {
      http_error_code_returned_equals = "200"
    }
    redirect {
      protocol  = "https"
      host_name = "www.${var.hostname}"
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "cors" {
  bucket = aws_s3_bucket_website_configuration.www_bucket.id

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.hostname}"]
    max_age_seconds = 3000
  }

}

# in main.tf, below the aforementioned boilerplate
resource "aws_s3_bucket_object" "file" {
  for_each = fileset(var.code_source, "**")

  bucket      = aws_s3_bucket_website_configuration.www_bucket.id
  key         = each.key
  source      = "${var.code_source}/${each.key}"
  source_hash = filemd5("${var.code_source}/${each.key}")
  acl         = "public-read"
}
