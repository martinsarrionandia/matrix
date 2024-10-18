data "aws_secretsmanager_secret" "matrix" {
  arn = var.matrix-secret-arn
}

data "aws_secretsmanager_secret_version" "matrix_current" {
  secret_id = data.aws_secretsmanager_secret.matrix.id
}