resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "artifact_bucket" {
  bucket        = "vprofile-artifacts-${random_id.bucket_suffix.hex}"
  force_destroy = true 

  tags = {
    Name    = "vprofile-artifacts"
    Project = var.ProjectName
  }
}