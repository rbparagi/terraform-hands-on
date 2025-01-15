resource "aws_iam_user" "iam_user_name" {    
    name = var.iam_user_name
    tags = {
      Name = "S3 User"
    }
}
# Attach AmazonS3FullAccess Policy
resource "aws_iam_user_policy_attachment" "s3_user_attachment" {
    user = aws_iam_user.iam_user_name.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

}