vpc_name                      = "rlph-global-vpc-prod"
lb_name                       = "rlph-global-lb-prod"
codedeploy_config_bucket_name = "rlph-global-code-deploy-config-bucket-prod"
host_name                     = "config.realpha.com"
private_subnet_names          = ["rlph-global-private-subnet-1-prod", "rlph-global-private-subnet-2-prod"]
ecs_capacity_provider_name    = "flagsmith-ecs-capacity-provider-prod"

task_cpu_units = 1792
task_memory_mb = 1378

database_pooler_enabled = true
database_pooler_host    = "realpha-db-pooler-prod-nlb-7c3d476d566d6ba9.elb.us-east-2.amazonaws.com"
database_pooler_port    = 6432
