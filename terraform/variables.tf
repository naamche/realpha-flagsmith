variable "application_name" {
  type    = string
  default = "flagsmith"
}

variable "application_port" {
  type    = number
  default = 8000
}

variable "lb_target_group_names" {
  type    = list(string)
  default = ["flagsmith-blue-tg", "flagsmith-green-tg"]
}

variable "health_check_path" {
  type    = string
  default = "/health"
}

variable "ami" {
  type    = string
  default = "ami-0e9663fd36090d7e0"
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "ecs_cluster_name" {
  type    = string
  default = "flagsmith-ecs-cluster"
}

variable "ecs_service_name" {
  type    = string
  default = "flagsmith-ecs-service"
}

variable "ecs_task_definition_family" {
  type    = string
  default = "flagsmith-ecs-task-definition"
}

variable "autoscaling_group_name" {
  type    = string
  default = "flagsmith-asg"
}

variable "launch_template_name" {
  type    = string
  default = "flagsmith-launch-template"
}

variable "codedeploy_deployment_group_name" {
  type    = string
  default = "flagsmith-codedeploy-deployment-group"
}

variable "parameter_store_path_name" {
  type    = string
  default = "/rlph/flagsmith/"
}

variable "global_parameter_store_path_name" {
  description = "Global infrastructure SSM path containing shared PrivateLink exports."
  type        = string
  default     = ""
}

variable "enable_shared_pooler_database_url" {
  description = "Whether this Flagsmith stack should manage DATABASE_URL to use the shared PgBouncer listener."
  type        = bool
  default     = false
}

variable "postgres_pooler_port" {
  description = "Shared PgBouncer listener port."
  type        = number
  default     = 6432
}

variable "ecs_execution_role_policy_name" {
  type    = string
  default = "flagsmith-ecs-execution-role-policy"
}

variable "ecs_execution_role_name" {
  type    = string
  default = "flagsmith-ecs-execution-role"
}

variable "ecs_task_role_policy_name" {
  type    = string
  default = "flagsmith-ecs-task-role-policy"
}

variable "ecs_task_role_name" {
  type    = string
  default = "flagsmith-ecs-task-role"
}

variable "all_addresses" {
  type    = string
  default = "0.0.0.0/0"
}


variable "ec2_security_group_name" {
  type    = string
  default = "flagsmith-ec2-security-group"
}

variable "ec2_instance_role_name" {
  type    = string
  default = "flagsmith-ec2-instance-role"
}

variable "ec2_iam_instance_profile_name" {
  type    = string
  default = "flagsmith-ec2-iam-instance-profile"
}

variable "codedeploy_policy_name" {
  type    = string
  default = "flagsmith-codedeploy-policy"
}

variable "codedeploy_iam_role_name" {
  type    = string
  default = "flagsmith-codedeploy-iam-role"
}

variable "cloudwatch_log_group_name" {
  type    = string
  default = "flagsmith-cloudwatch-log-group"
}

variable "host_name" {
  type = string

  validation {
    condition     = var.host_name == "config.realpha.com"
    error_message = "Flagsmith infrastructure is prod-only; host_name must be config.realpha.com."
  }
}

variable "vpc_name" {
  type = string

  validation {
    condition     = var.vpc_name == "rlph-global-vpc-prod"
    error_message = "Flagsmith infrastructure is prod-only; vpc_name must be rlph-global-vpc-prod."
  }
}

variable "private_subnet_names" {
  type = list(string)

  validation {
    condition     = alltrue([for name in var.private_subnet_names : endswith(name, "-prod")])
    error_message = "Flagsmith infrastructure is prod-only; private subnet names must target prod."
  }
}

variable "codedeploy_config_bucket_name" {
  type = string

  validation {
    condition     = var.codedeploy_config_bucket_name == "rlph-global-code-deploy-config-bucket-prod"
    error_message = "Flagsmith infrastructure is prod-only; codedeploy_config_bucket_name must target prod."
  }
}

variable "lb_name" {
  type = string

  validation {
    condition     = var.lb_name == "rlph-global-lb-prod"
    error_message = "Flagsmith infrastructure is prod-only; lb_name must be rlph-global-lb-prod."
  }
}

variable "ecs_capacity_provider_name" {
  type = string

  validation {
    condition     = var.ecs_capacity_provider_name == "flagsmith-ecs-capacity-provider-prod"
    error_message = "Flagsmith infrastructure is prod-only; ecs_capacity_provider_name must target prod."
  }
}

variable "task_cpu_units" {
  type    = number
  default = 2048
}

variable "task_memory_mb" {
  type    = number
  default = 1890
}
