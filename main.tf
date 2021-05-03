module "redis" {
  source                       = "git::https://github.com/cloudposse/terraform-aws-elasticache-redis.git?ref=0.37.0"
  notification_topic_arn       = var.sns_topic_arn
  availability_zones           = var.availability_zones
  namespace                    = var.namespace
  stage                        = ""
  name                         = "${var.project}-${lookup(var.short_env, var.env, "dev")}-redis-${random_string.str.result}"
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

resource "aws_cloudwatch_metric_alarm" "eviction_alarm" {
  alarm_name                = "${var.project}-${lookup(var.short_env, var.env, "dev")}-redis-${random_string.str.result}-${random_string.str.result}-001-alarm-eviction"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "Evictions"
  namespace                 = "AWS/ElastiCache"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "10"
  alarm_description         = "This metric monitors redis evictions"
  tags                      = var.tags
  dimensions                = {
    "CacheClusterId"        = "${module.redis.id}-001"
  }
  actions_enabled           = true
    alarm_actions             = [
      var.sns_topic_arn
    ]
    ok_actions                = [
      var.sns_topic_arn
    ]
  treat_missing_data        = "missing"
}

resource "aws_cloudwatch_metric_alarm" "currconnections_alarm" {
  alarm_name                = "${var.project}-${lookup(var.short_env, var.env, "dev")}-redis-${random_string.str.result}-${random_string.str.result}-001-alarm-currconnection"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "CurrConnections"
  namespace                 = "AWS/ElastiCache"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "50"
  alarm_description         = "This metric monitors redis current connections"
  tags                      = var.tags
  dimensions                = {
    "CacheClusterId"        = "${module.redis.id}-001"
  }
  actions_enabled           = true
    alarm_actions             = [
      var.sns_topic_arn
    ]
    ok_actions                = [
      var.sns_topic_arn
    ]
  treat_missing_data        = "missing"
}
