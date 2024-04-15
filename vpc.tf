resource "aws_vpc" "vpc_ms" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "sub_ms_a" {
  vpc_id                  = aws_vpc.vpc_ms.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.region}${var.az_subnet_a}"
}

resource "aws_subnet" "sub_ms_b" {
  vpc_id                  = aws_vpc.vpc_ms.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.region}${var.az_subnet_b}"
}

# Gravar id da VPC para utilização no microserviço
resource "aws_ssm_parameter" "id_vpc_ms" {
  name  = "/ms/vpc/id_vpc_ms"
  type  = "String"
  value = aws_vpc.vpc_ms.id
}

# Gravar id das Subnets para utilização no microserviço
resource "aws_ssm_parameter" "id_sub_ms_a" {
  name  = "/ms/vpc/id_sub_ms_a"
  type  = "String"
  value = aws_subnet.sub_ms_a.id
}

resource "aws_ssm_parameter" "id_sub_ms_b" {
  name  = "/ms/vpc/id_sub_ms_b"
  type  = "String"
  value = aws_subnet.sub_ms_b.id
}
