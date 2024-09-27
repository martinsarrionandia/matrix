data "aws_secretsmanager_secret" "matrix" {
  arn = "arn:aws:secretsmanager:eu-west-2:281287281094:secret:matrix-fFyAgI"
}

data "aws_secretsmanager_secret_version" "matrix_current" {
  secret_id = data.aws_secretsmanager_secret.matrix.id
}