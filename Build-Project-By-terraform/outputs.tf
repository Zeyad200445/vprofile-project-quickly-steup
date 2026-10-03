output "RDS-eNDPIONT" {
  value = aws_db_instance.vprofile-DB.endpoint
}
output "mem-eNDPIONT" {
  value = aws_elasticache_cluster.memcache.configuration_endpoint
}
output "rabbit-eNDPIONT" {
  value = aws_mq_broker.rabbitmq.instances.0.endpoints
}
output "s3_bucket_name" {
  value       = aws_s3_bucket.artifact_bucket.bucket
  description = "The automatically generated S3 bucket name for artifacts"
}