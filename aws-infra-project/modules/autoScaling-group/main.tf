

resource "aws_launch_template" "app_lt" {
  name_prefix   = "mern-app-"
  image_id      = var.ami_value
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [var.app_sg_id]


}

resource "aws_autoscaling_group" "app_asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 2
  vpc_zone_identifier  = var.private_subnet_ids
  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }
  target_group_arns = [var.tg_frontend_arn, var.tg_backend_arn]
  tag {
    key                 = "Name"
    value               = "mern-instance"
    propagate_at_launch = true
  }
}







