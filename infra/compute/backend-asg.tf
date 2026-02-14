resource "aws_launch_template" "backend" {
  name_prefix   = "${var.namespace}-${var.environment}-backend-"
  image_id      = data.aws_ami.ecs_al2023_arm64.id
  instance_type = var.backend_instance_type
  key_name      = aws_key_pair.default.key_name

  vpc_security_group_ids = [var.backend_security_group_id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance.name
  }

  user_data = base64encode(templatefile("${path.module}/user-data-ecs.sh", {
    cluster_name = local.backend_cluster_name
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.namespace}-${var.environment}-backend-ec2"
      Environment = var.environment
    }
  }
}

resource "aws_autoscaling_group" "backend" {
  name                = "${var.namespace}-${var.environment}-backend-asg"
  max_size            = var.backend_asg_max
  min_size            = var.backend_asg_min
  desired_capacity    = var.backend_asg_desired
  vpc_zone_identifier = var.public_subnet_ids

  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 60

  tag {
    key                 = "Name"
    value               = "${var.namespace}-${var.environment}-backend-ec2"
    propagate_at_launch = true
  }
}
