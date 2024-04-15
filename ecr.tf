resource "aws_ecr_repository" "ecr_ms" {
  name = var.ecr_name 
}

#Gravar URL do repository para utilização no microserviço
resource "aws_ssm_parameter" "repository_url_ecr_ms" {
  name  = "/ms/ecr/repository_url_ecr_ms"
  type  = "String"
  value = aws_ecr_repository.ecr_ms.repository_url
}