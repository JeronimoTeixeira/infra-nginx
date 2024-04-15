resource "aws_ecs_cluster" "ecs_ms" {
  name = var.ecs_name

  tags = {
    microservico = "ms"
  }
}

#Gravar id do ECS para utilização no microserviço
resource "aws_ssm_parameter" "id_ecs_ms" {
  name  = "/ms/ecs/ecs_ms"
  type  = "String"
  value = aws_ecs_cluster.ecs_ms.id
}