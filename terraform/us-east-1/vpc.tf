resource "aws_vpc" "EC2VPC" {
    cidr_block = "172.32.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = "default"
}

resource "aws_subnet" "EC2Subnet" {
    availability_zone = "us-east-1a"
    cidr_block = "172.32.80.0/20"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "EC2Subnet2" {
    availability_zone = "us-east-1e"
    cidr_block = "172.32.48.0/20"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "EC2Subnet3" {
    availability_zone = "us-east-1b"
    cidr_block = "172.32.16.0/20"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "EC2InternetGateway" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
}

resource "aws_vpc_dhcp_options" "EC2DHCPOptions" {
    domain_name = "ec2.internal"
}


resource "aws_network_acl" "EC2NetworkAcl" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
}


resource "aws_route_table" "EC2RouteTable" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
}

resource "aws_route" "EC2Route" {
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.EC2InternetGateway.id}"
    route_table_id = "${aws_route_table.EC2RouteTable.id}"
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssoc" {
  subnet_id      = aws_subnet.EC2Subnet.id
  route_table_id = aws_route_table.EC2RouteTable.id
}

resource "aws_route_table_association" "EC2Subnet2RouteTableAssoc" {
  subnet_id      = aws_subnet.EC2Subnet2.id
  route_table_id = aws_route_table.EC2RouteTable.id
}

resource "aws_route_table_association" "EC2Subnet3RouteTableAssoc" {
  subnet_id      = aws_subnet.EC2Subnet3.id
  route_table_id = aws_route_table.EC2RouteTable.id
}