module "redis" {
  source                       = "git::https://github.com/cloudposse/terraform-aws-elasticache-redis.git?ref=0.23.0"
  notification_topic_arn       = var.sns_topic_arn
  availability_zones           = var.availability_zones
  namespace                    = var.namespace
  stage                        = lookup(var.short_env, var.env, "dev")
  name                         = "${var.name}-${random_string.str.result}"
  zone_id                      = var.zone_id
  vpc_id                       = var.vpc_id
  allowed_security_groups      = var.allowed_security_groups
  subnets                      = var.subnets
  cluster_size                 = var.cluster_size
  instance_type                = var.instance_type
  apply_immediately            = var.apply_immediately
  automatic_failover_enabled   = var.automatic_failover_enabled
  engine_version               = var.engine_version
  family                       = var.family
  at_rest_encryption_enabled   = var.at_rest_encryption_enabled
  transit_encryption_enabled   = var.transit_encryption_enabled
  tags                         = var.tags
  alarm_memory_threshold_bytes = var.alarm_memory_threshold_bytes
  alarm_cpu_threshold_percent  = var.alarm_cpu_threshold_percent
  alarm_actions                = [ var.sns_topic_arn ]
  ok_actions                   = [ var.sns_topic_arn ]
}

// add additionnal cloudwatch alert here
