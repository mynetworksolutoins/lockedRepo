provider "aws" {
  region = "us-east-1"
  access_key = "ABC123"
  secret_key = "ABC123"
}

#IP Target Group

resource "aws_lb_target_group" "abctestLbTargetGroup1" {
  name        = "abctestLbTargetGroup1"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "vpc-02829a9bc4b9b886d"
}

#aws_lb_target_group_attachment

resource "aws_lb_target_group_attachment" "abctestLbTargetGroup1Attachment" {
  target_group_arn = "${aws_lb_target_group.abctestLbTargetGroup1.arn}"
  target_id        = "10.1.1.14"
  port             = 80
}

#aws_Application Load Balancer

resource "aws_lb" "abctestLb" {
  name               = "abctestLb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-031910cda79027c83",""]
  subnets            = ["subnet-0d7777587e0911650","subnet-02fcc9cde86835e6c"]

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.my-blue-s3-bucket.id
    prefix  = "alb3"
    enabled = true
  }
}
