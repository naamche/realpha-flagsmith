resource "aws_launch_template" "default_launch_template" {
  name_prefix   = var.launch_template_name
  image_id      = var.ami
  instance_type = var.instance_type

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  user_data = base64encode(<<EOF
#! /bin/bash
sudo apt-get update
sudo echo "ECS_CLUSTER=${var.ecs_cluster_name}" >> /etc/ecs/ecs.config
EOF
  )

  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_iam_instance_profile.arn
  }
}
