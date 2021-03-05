variable "region"{}
variable "shared_credentials_file"{}
variable "profile"{}
variable "public_key"{}

provider "aws" {
    region = "${var.region}"
    shared_credentials_file = "${var.shared_credentials_file}"
    profile = "${var.profile}"
}

resource "aws_key_pair" "EC2KeyPair" {
    public_key = "${var.public_key}"
    key_name = "gmile-amzn"
}

resource "aws_instance" "EC2Instance2" {
    ami = "ami-0915bcb5fa77e4892"
    instance_type = "t2.micro"
    key_name = "gmile-amzn"
    availability_zone = "${var.region}a"
    tenancy = "default"
    subnet_id = "${aws_subnet.EC2Subnet.id}"
    ebs_optimized = false
    vpc_security_group_ids = [
        "${aws_security_group.EC2SecurityGroup.id}"
    ]
    source_dest_check = true
    root_block_device {
        volume_size = 8
        volume_type = "gp2"
        delete_on_termination = false
    }
    iam_instance_profile = "${aws_iam_role.IAMRole.name}"
    tags = { 
        Name = "gmile-jenkins-server"
    }
}

resource "aws_instance" "EC2Instance3" {
    ami = "ami-0915bcb5fa77e4892"
    instance_type = "t2.micro"
    key_name = "gmile-amzn"
    availability_zone = "${var.region}a"
    tenancy = "default"
    subnet_id = "${aws_subnet.EC2Subnet.id}"
    ebs_optimized = false
    vpc_security_group_ids = [
        "${aws_security_group.EC2SecurityGroup.id}"
    ]
    source_dest_check = true
    root_block_device {
        volume_size = 8
        volume_type = "gp2"
        delete_on_termination = false
    }
    iam_instance_profile = "${aws_iam_role.IAMRole.name}"
    tags = { 
        Name = "gmile-monitoring-server"
    }
}


resource "aws_security_group" "EC2SecurityGroup" {
    description = "created 2021-03-01T12:33:23.618-03:00"
    name = "gmile-sg"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    ingress {
        from_port = 0
        to_port = 0
        cidr_blocks = [
            "200.17.34.0/24"
        ]
        protocol = "-1"
    }
    ingress {
        from_port = 0
        to_port = 0
        cidr_blocks = [
            "200.19.188.0/24"
        ]
        protocol = "-1"
    }
    ingress {
        from_port = 0
        to_port = 0
        cidr_blocks = [
            "200.19.189.0/24"
        ]
        protocol = "-1"
    }
    ingress {
        from_port = 0
        to_port = 0
        cidr_blocks = [
            "200.253.187.0/24"
        ]
        protocol = "-1"
    }
    ingress {
        from_port = 0
        to_port = 0
        cidr_blocks = [
            "177.91.140.0/22"
        ]
        protocol = "-1"
    }
    egress {
        from_port = 0
        to_port = 0
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        protocol = "-1"
    }
    ingress {
        from_port = 0
        to_port = 0
        self = true
        protocol = "-1"
    }
}

