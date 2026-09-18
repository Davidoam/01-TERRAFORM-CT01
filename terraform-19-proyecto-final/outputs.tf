output "vpc_id" {
  value = aws_vpc.principal.id
}

output "ec2_id" {
  value = aws_instance.web.id
}

output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}

output "bucket_name" {
  value = aws_s3_bucket.principal.bucket
}