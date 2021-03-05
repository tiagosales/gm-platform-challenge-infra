resource "aws_lb" "ElasticLoadBalancingV2LoadBalancer" {
    name = "gmile-lb"
    internal = false
    load_balancer_type = "application"
    subnets = [
        "${aws_subnet.EC2Subnet.id}",
        "${aws_subnet.EC2Subnet2.id}",
        "${aws_subnet.EC2Subnet3.id}"
    ]
    security_groups = [
        "${aws_security_group.EC2SecurityGroup.id}"
    ]
    ip_address_type = "ipv4"
    access_logs {
        enabled = "false"
        bucket = ""
        prefix = ""
    }
    idle_timeout = "60"
    enable_deletion_protection = "false"
    enable_http2 = "true"
}

resource "aws_lb_listener" "ElasticLoadBalancingV2Listener" {
    load_balancer_arn = "${aws_lb.ElasticLoadBalancingV2LoadBalancer.arn}"
    port = 80
    protocol = "HTTP"
    default_action {
        target_group_arn = "${aws_lb_target_group.ElasticLoadBalancingV2TargetGroup2.arn}"
        type = "forward"
    }
}

resource "aws_lb_listener_rule" "ElasticLoadBalancingV2ListenerRule" {
    priority = "1"
    listener_arn = "${aws_lb_listener.ElasticLoadBalancingV2Listener.arn}"
    action {
        target_group_arn = "${aws_lb_target_group.ElasticLoadBalancingV2TargetGroup2.arn}"
        type = "forward"
    }
    condition {
        path_pattern {
            values = ["/*"]
        }
    }
}

resource "aws_lb_target_group" "ElasticLoadBalancingV2TargetGroup" {
    health_check {
        interval = 30
        path = "/"
        port = "traffic-port"
        protocol = "HTTP"
        timeout = 5
        unhealthy_threshold = 2
        healthy_threshold = 5
        matcher = "200"
    }
    port = 80
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    name = "gmile-dg1"
}

resource "aws_lb_target_group" "ElasticLoadBalancingV2TargetGroup2" {
    health_check {
        interval = 30
        path = "/actuator/health"
        port = "traffic-port"
        protocol = "HTTP"
        timeout = 5
        unhealthy_threshold = 2
        healthy_threshold = 5
        matcher = "200"
    }
    port = 80
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    name = "gmile-service"
}