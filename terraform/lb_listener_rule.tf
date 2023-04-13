resource "aws_lb_listener_rule" "default_lb_listener_rule" {
  listener_arn = data.aws_lb_listener.lb_listener.arn
  priority     = 94

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default_target_groups[0].arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
  condition {
    host_header {
      values = [var.host_name]
    }
  }
  lifecycle {
    ignore_changes = [action]
  }
}