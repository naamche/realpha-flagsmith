resource "aws_ecs_service" "default_ecs_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.default_ecs_cluster.name
  task_definition = aws_ecs_task_definition.default_ecs_task_definition.arn

  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  force_new_deployment               = false
  enable_execute_command             = true
  enable_ecs_managed_tags            = true

  lifecycle {
    ignore_changes = [task_definition, desired_count, load_balancer, capacity_provider_strategy]
  }

  capacity_provider_strategy {
    base              = 0
    weight            = 1
    capacity_provider = var.ecs_capacity_provider_name
  }

  load_balancer {
    target_group_arn = element(aws_lb_target_group.default_target_groups[*].arn, 0)
    container_name   = var.application_name
    container_port   = var.application_port
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }
}
