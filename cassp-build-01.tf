resource "aws_s3_bucket" "bucket" {
  bucket = "cassp-build-01"
  acl    = "private"

  tags = {
    Name        = "cassp-build-01"
      }
}
