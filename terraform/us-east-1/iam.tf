resource "aws_iam_role" "IAMRole" {
    path = "/"
    name = "gmile-JenkinsRole"
    assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ec2.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
    max_session_duration = 3600
}


resource "aws_iam_role" "IAMRole2" {
    path = "/"
    name = "gmile-ecsTaskExecutionRole"
    assume_role_policy = "{\"Version\":\"2008-10-17\",\"Statement\":[{\"Sid\":\"\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ecs-tasks.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
    max_session_duration = 3600
}

resource "aws_iam_policy" "IAMManagedPolicy1" {
    name = "gmile-ECS-Jenkins-Permissions"
    path = "/"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ecs:UpdateService",
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "ecs:ListTaskDefinitions",
                "ecs:DescribeTaskDefinition",
                "ecs:ListTasks",
                "ecs:DescribeTasks"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "IAMManagedPolicy2" {
    name = "gmile-JenkinsRiampolicy"
    path = "/"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetSecretValue",
                "secretsmanager:CreateSecret",
                "secretsmanager:ListSecrets",
                "secretsmanager:TagResource"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "IAMManagedPolicy3" {
    name = "gmile-iam-Jenkins-policy"
    path = "/"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "IAMManagedPolicy4" {
    name = "gmile-ECR-iampolicy"
    path = "/"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:UploadLayerPart",
                "ecr:InitiateLayerUpload",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "ecr:GetAuthorizationToken",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "policyattachment1" {
  role       = "${aws_iam_role.IAMRole.name}"
  policy_arn = "${aws_iam_policy.IAMManagedPolicy1.arn}"
}

resource "aws_iam_role_policy_attachment" "policyattachment2" {
  role       = "${aws_iam_role.IAMRole.name}"
  policy_arn = "${aws_iam_policy.IAMManagedPolicy2.arn}"
}

resource "aws_iam_role_policy_attachment" "policyattachment3" {
  role       = "${aws_iam_role.IAMRole.name}"
  policy_arn = "${aws_iam_policy.IAMManagedPolicy3.arn}"
}

resource "aws_iam_role_policy_attachment" "policyattachmen4" {
  role       = "${aws_iam_role.IAMRole.name}"
  policy_arn = "${aws_iam_policy.IAMManagedPolicy4.arn}"
}
resource "aws_iam_role_policy_attachment" "policyattachmen5" {
  role       = "${aws_iam_role.IAMRole.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = "${aws_iam_role.IAMRole2.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_instance_profile" "IAMInstanceProfile" {
    path = "/"
    name = "${aws_iam_role.IAMRole.name}"
    role = "${aws_iam_role.IAMRole.name}"
}
