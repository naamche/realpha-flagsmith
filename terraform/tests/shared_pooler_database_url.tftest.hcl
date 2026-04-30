mock_provider "aws" {
  override_during = plan

  mock_data "aws_caller_identity" {
    defaults = {
      account_id = "123456789012"
    }
  }

  mock_data "aws_lb" {
    defaults = {
      arn = "arn:aws:elasticloadbalancing:us-east-2:123456789012:loadbalancer/app/test/123"
    }
  }

  mock_data "aws_lb_listener" {
    defaults = {
      arn = "arn:aws:elasticloadbalancing:us-east-2:123456789012:listener/app/test/123/456"
    }
  }

  mock_data "aws_s3_bucket" {
    defaults = {
      arn = "arn:aws:s3:::mock-codedeploy-config"
    }
  }

  mock_data "aws_ssm_parameter" {
    defaults = {
      value = "mock-value"
    }
  }

  mock_data "aws_ssm_parameters_by_path" {
    defaults = {
      names = []
    }
  }

  mock_data "aws_subnets" {
    defaults = {
      ids = ["subnet-a", "subnet-b"]
    }
  }

  mock_data "aws_vpc" {
    defaults = {
      cidr_block = "10.0.0.0/16"
      id         = "vpc-test"
    }
  }
}

variables {
  application_name                  = "flagsmith"
  host_name                         = "config.realpha.com"
  vpc_name                          = "rlph-global-vpc-prod"
  private_subnet_names              = ["rlph-global-private-subnet-1-prod", "rlph-global-private-subnet-2-prod"]
  codedeploy_config_bucket_name     = "rlph-global-code-deploy-config-bucket-prod"
  lb_name                           = "rlph-global-lb-prod"
  ecs_capacity_provider_name        = "flagsmith-ecs-capacity-provider-prod"
  parameter_store_path_name         = "/rlph/flagsmith/"
  enable_shared_pooler_database_url = true
  global_parameter_store_path_name  = "/rlph/global-infrastructure/prod/"
  postgres_pooler_port              = 6432
}

run "flagsmith_database_url_uses_shared_pooler_nlb" {
  command = plan

  override_data {
    target = data.aws_ssm_parameter.current_flagsmith_database_url[0]
    values = {
      value = "postgresql://flagsmith:secret@old-dedicated-pooler.elb.us-east-2.amazonaws.com:6432/flagsmith"
    }
  }

  override_data {
    target = data.aws_ssm_parameter.shared_privatelink_nlb_dns_name[0]
    values = {
      value = "shared-pooler.elb.us-east-2.amazonaws.com"
    }
  }

  assert {
    condition     = aws_ssm_parameter.flagsmith_database_url[0].name == "/rlph/flagsmith/common/DATABASE_URL"
    error_message = "Flagsmith DATABASE_URL must be managed at the runtime SSM path consumed by the ECS task."
  }

  assert {
    condition     = nonsensitive(aws_ssm_parameter.flagsmith_database_url[0].value) == "postgresql://flagsmith:secret@shared-pooler.elb.us-east-2.amazonaws.com:6432/flagsmith"
    error_message = "Flagsmith DATABASE_URL must preserve credentials/database while using the shared reAlpha pooler NLB."
  }
}

run "flagsmith_database_url_is_not_managed_when_disabled" {
  command = plan

  variables {
    enable_shared_pooler_database_url = false
  }

  assert {
    condition     = length(aws_ssm_parameter.flagsmith_database_url) == 0
    error_message = "Non-prod Flagsmith stacks must not manage DATABASE_URL for the shared pooler."
  }
}

run "staging_stack_is_blocked" {
  command = plan

  variables {
    vpc_name                          = "rlph-global-vpc-staging"
    lb_name                           = "rlph-global-lb-staging"
    codedeploy_config_bucket_name     = "rlph-global-code-deploy-config-bucket-staging"
    host_name                         = "config-staging.realpha.com"
    private_subnet_names              = ["rlph-global-private-subnet-1-staging", "rlph-global-private-subnet-2-staging"]
    ecs_capacity_provider_name        = "flagsmith-ecs-capacity-provider-staging"
    enable_shared_pooler_database_url = false
  }

  expect_failures = [
    var.vpc_name,
    var.lb_name,
    var.codedeploy_config_bucket_name,
    var.host_name,
    var.private_subnet_names,
    var.ecs_capacity_provider_name,
  ]
}
