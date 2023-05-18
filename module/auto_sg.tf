# # Create a target group for EC2 Instances
# resource "aws_lb_target_group" "web-servers-tg" {
#   name        = "terra-tg"
#   port        = 80
#   protocol    = "HTTP"
#   target_type = "instance"
#   vpc_id      = aws_vpc.my_test_vpc1.id

#   health_check {
#     path                = "/"
#     port                = "traffic-port"
#     protocol            = "HTTP"
#     matcher             = "200-399"
#     interval            = 10
#     timeout             = 5
#     healthy_threshold   = 3
#     unhealthy_threshold = 3
#     enabled             = true
#   }
# }

# # Load Balancer configuration for Instances
# resource "aws_lb" "web-servers-lb" {
#   name               = "instance-lb"
#   internal           = false
#   load_balancer_type = "application"
#   ip_address_type    = "ipv4"
#   security_groups    = [aws_security_group.my_asg.id]
#   subnets            = [aws_subnet.my_test_vpc1_PublicSubnet1.id, aws_subnet.my_test_vpc1_PublicSubnet2.id]

#   enable_deletion_protection = false

#   tags = {
#     Environment = "Terra-LoadBalancer"
#   }
# }

# # Create Load Balancer Listener to listen to the forwarded traffic from LoadBalancer 
# resource "aws_lb_listener" "front_end" {
#   load_balancer_arn = aws_lb.web-servers-lb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.web-servers-tg.arn
#   }
# }



# # Attach Nginx Instance to a Target group
# resource "aws_lb_target_group_attachment" "instance-tg-attach-nginx" {
#   target_group_arn = aws_lb_target_group.web-servers-tg.arn
#   target_id        = aws_launch_template.web-servers-lt.id
#   port             = 80
# }


# # ASG and component declaretion
# resource "aws_launch_template" "web-servers-lt" {
#   name                   = "web-servers-lt"
#   image_id               = "ami-0aa2b7722dc1b5612"
#   instance_type          = "t2.micro"
#   key_name               = "aws_key"
#   vpc_security_group_ids = ["${aws_security_group.my_asg.id}"]
#   user_data     = base64encode("${data.template_file.user_data1.rendered}")

#   tag_specifications {
#     resource_type = "instance"
#     tags = {
#       Name : "Nginx-web-server"
#     }
#   }
# }

# resource "aws_autoscaling_group" "terraform-asg" {
#   name                      = "terraform-asg"
#   vpc_zone_identifier       = aws_lb.web-servers-lb.subnets
#   min_size                  = 2
#   max_size                  = 4
#   desired_capacity          = 2
#   health_check_grace_period = 300
#   health_check_type         = "ELB"
#   target_group_arns         = [aws_lb_target_group.web-servers-tg.arn]

#   launch_template {
#     id      = aws_launch_template.web-servers-lt.id
#     version = "$Latest"
#   }
# }