# Create IAM users: user1, user2, user3
resource "aws_iam_user" "users" {
  for_each = toset(["user1", "user2", "user3"])

  name = each.value
}

# Attach Amazon S3 Read-Only Access policy to each user
resource "aws_iam_user_policy_attachment" "s3_readonly" {
  for_each = toset(["user1", "user2", "user3"])

  user       = aws_iam_user.users[each.value].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Attach Amazon EC2 Read-Only Access policy to each user
resource "aws_iam_user_policy_attachment" "ec2_readonly" {
  for_each = toset(["user1", "user2", "user3"])

  user       = aws_iam_user.users[each.value].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}
