resource "aws_iam_role" "ssm_managed_instance" {
  name        = "ssm-managed-instance"
  description = "Allows SSM to manage the instance"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ssm_managed_instance_policy" {
  name        = "ssm-managed-instance-policy"
  description = "Allows SSM to manage the instance"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ssm:StartSession",
        "ssm:SendCommand",
        "ssm:GetCommandInvocation",
        "ssm:UpdateInstanceInformation"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_policy_attachment" {
  role       = aws_iam_role.ssm_managed_instance.name
  policy_arn = aws_iam_policy.ssm_managed_instance_policy.arn
}

resource "aws_iam_instance_profile" "ssm_managed_instance" {
  name = "ssm-managed-instance"
  role = aws_iam_role.ssm_managed_instance.name
}
