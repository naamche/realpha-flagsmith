vpc_name                          = "rlph-global-vpc-prod"
lb_name                           = "rlph-global-lb-prod"
codedeploy_config_bucket_name     = "rlph-global-code-deploy-config-bucket-prod"
host_name                         = "config.realpha.com"
private_subnet_names              = ["rlph-global-private-subnet-1-prod", "rlph-global-private-subnet-2-prod"]
ecs_capacity_provider_name        = "flagsmith-ecs-capacity-provider-prod"
enable_shared_pooler_database_url = true
global_parameter_store_path_name  = "/rlph/global-infrastructure/prod/"
postgres_pooler_port              = 6432

task_cpu_units = 1792
task_memory_mb = 1378
