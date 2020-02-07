module "redis" {
  source                     = "git::https://github.com/cloudposse/terraform-aws-elasticache-redis.git?ref=0.14.0"
  availability_zones         = var.availability_zones
  namespace                  = var.namespace
  stage                      = lookup(var.short_env, var.env, "dev")
  name                       = var.name
  zone_id                    = var.zone_id
  vpc_id                     = var.vpc_id
  allowed_security_groups    = var.allowed_security_groups
  subnets                    = var.subnets
  cluster_size               = var.cluster_size
  instance_type              = var.instance_type
  apply_immediately          = var.apply_immediately
  automatic_failover_enabled = var.automatic_failover_enabled
  engine_version             = var.engine_version
  family                     = var.family
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
}
