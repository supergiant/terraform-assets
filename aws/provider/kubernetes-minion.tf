resource "aws_iam_role_policy" "kubernetes-minion" {
    name = "kubernetes-minion"
    role = "${aws_iam_role.kubernetes-minion.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::kubernetes-*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:AttachVolume",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:DetachVolume",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "kubernetes-minion" {
    name = "kubernetes-minion"
    path = "/"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {"AWS": "*"},
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "kubernetes-minion" {
    name  = "kubernetes-minion"
    path  = "/"
    roles = ["${aws_iam_role.kubernetes-minion.name}"]
}
