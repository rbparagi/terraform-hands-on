resource "aws_s3_bucket" "example" {
  bucket = "ravi-paragi-test-bucket"
  versioning {
    enabled = true
  }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}