output "gmile-jenkins-server" {
  value = aws_instance.EC2Instance2.public_ip
}
output "gmile-monitoring-server" {
  value = aws_instance.EC2Instance3.public_ip
}
output "app-access" {
  value       = aws_lb.ElasticLoadBalancingV2LoadBalancer.dns_name
}
