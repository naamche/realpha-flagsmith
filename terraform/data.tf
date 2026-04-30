data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_lb" "lb" {
  name = var.lb_name
}

data "aws_lb_listener" "lb_listener" {
  load_balancer_arn = data.aws_lb.lb.arn
  port              = 443
}

data "aws_s3_bucket" "codedeploy_config_bucket" {
  bucket = var.codedeploy_config_bucket_name
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Name"
    values = var.private_subnet_names
  }
}

data "aws_ssm_parameters_by_path" "postgres_ssm_parameters" {
  path = "${var.parameter_store_path_name}postgres"
}

data "aws_ssm_parameters_by_path" "common_ssm_parameters" {
  path = "${var.parameter_store_path_name}common"
}

data "aws_ssm_parameters_by_path" "flagsmith_ssm_parameters" {
  path = "${var.parameter_store_path_name}flagsmith"
}

data "aws_ssm_parameters_by_path" "flagsmith_processor_ssm_parameters" {
  path = "${var.parameter_store_path_name}flagsmith_processor"
}

data "aws_ssm_parameter" "current_flagsmith_database_url" {
  count = var.enable_shared_pooler_database_url ? 1 : 0

  name            = "${var.parameter_store_path_name}common/DATABASE_URL"
  with_decryption = true
}

data "aws_ssm_parameter" "shared_privatelink_nlb_dns_name" {
  count = var.enable_shared_pooler_database_url ? 1 : 0

  name = "${var.global_parameter_store_path_name}SHARED_PRIVATELINK_NLB_DNS_NAME"
}

data "aws_caller_identity" "current_account" {}
data "aws_region" "current_region" {}
