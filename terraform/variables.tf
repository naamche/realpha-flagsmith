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
}

variable "vpc_name" {
  type = string
}

variable "private_subnet_names" {
  type = list(string)
}

variable "codedeploy_config_bucket_name" {
  type = string
}

variable "lb_name" {
  type = string
}

variable "ecs_capacity_provider_name" {
  type = string
}

variable "task_cpu_units" {
  type    = number
  default = 2048
}

variable "task_memory_mb" {
  type    = number
  default = 1890
}