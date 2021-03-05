resource "aws_ecs_cluster" "ECSCluster" {
    name = "gmile-ecs-cluster"
} 

resource "aws_ecs_service" "ECSService" {
    name = "gmile-service"
    cluster = "${aws_ecs_cluster.ECSCluster.arn}"
    load_balancer {
        target_group_arn = "${aws_lb_target_group.ElasticLoadBalancingV2TargetGroup2.arn}"
        container_name = "gmile-app"
        container_port = 8080
    }
    desired_count = 1
    launch_type = "FARGATE"
    platform_version = "LATEST"
    task_definition = "${aws_ecs_task_definition.ECSTaskDefinition.arn}"
    deployment_maximum_percent = 200
    deployment_minimum_healthy_percent = 100
    network_configuration {
        assign_public_ip = true
        security_groups = [
            "${aws_security_group.EC2SecurityGroup.id}"
        ]
        subnets = [
            "${aws_subnet.EC2Subnet.id}",
            "${aws_subnet.EC2Subnet2.id}",
            "${aws_subnet.EC2Subnet3.id}"
        ]
    }
    health_check_grace_period_seconds = 0
    scheduling_strategy = "REPLICA"
}

resource "aws_ecs_task_definition" "ECSTaskDefinition" {
    container_definitions = "[{\"name\":\"gmile-app\",\"image\":\"${aws_ecr_repository.ECRRepository.repository_url}:latest\",\"cpu\":0,\"portMappings\":[{\"containerPort\":8080,\"hostPort\":8080,\"protocol\":\"tcp\"}],\"essential\":true,\"environment\":[],\"mountPoints\":[],\"volumesFrom\":[],\"logConfiguration\":{\"logDriver\":\"awslogs\",\"options\":{\"awslogs-group\":\"${aws_cloudwatch_log_group.LogsLogGroup.name}\",\"awslogs-region\":\"${var.region}\",\"awslogs-stream-prefix\":\"ecs\"}}}]"
    family = "gmile-app"
    execution_role_arn = "${aws_iam_role.IAMRole2.arn}"
    network_mode = "awsvpc"
    requires_compatibilities = [
        "FARGATE"
    ]
    cpu = "256"
    memory = "512"
}