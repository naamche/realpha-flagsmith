vpc_name                      = "rlph-global-vpc-prod"
lb_name                       = "rlph-global-lb-prod"
codedeploy_config_bucket_name = "rlph-global-code-deploy-config-bucket-prod"
host_name                     = "config.realpha.com"
private_subnet_names          = ["rlph-global-private-subnet-1-prod", "rlph-global-private-subnet-2-prod"]
ecs_capacity_provider_name    = "flagsmith-ecs-capacity-provider-prod"
