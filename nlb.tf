resource "aws_lb" "nlb_ms" {
  name               = var.nlb_name
  internal           = false
  ip_address_type = "ipv4"
  load_balancer_type = "network"
  
  subnet_mapping {
    subnet_id     = aws_subnet.sub_ms_a.id
  }
  
  subnet_mapping {
    subnet_id     = aws_subnet.sub_ms_b.id
  }

  tags = {
    microservico = "ms"
  }
}

#Gravar ARN do NLB para utilização no microserviço
resource "aws_ssm_parameter" "arn_nlb_ms" {
  name  = "/ms/lb/arn_nlb_ms"
  type  = "String"
  value = aws_lb.nlb_ms.arn
}