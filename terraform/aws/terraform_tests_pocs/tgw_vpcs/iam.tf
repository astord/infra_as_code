resource "aws_iam_role" "ec2_node" {
  name = "irl-test-ec2-node"

  assume_role_policy = <<POLICY
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
POLICY

}

resource "aws_iam_instance_profile" "ec2_node" {
  name = "irl-test-ec2-node"
  role = aws_iam_role.ec2_node.name
}

resource "aws_iam_role_policy_attachment" "ec2_node" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ec2_node.name
}
