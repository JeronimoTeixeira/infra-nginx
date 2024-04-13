variable "profile" {
  description = "Profile para deploy"
  type = string
  default = "localstack"
}

variable "region" {
  description = "Regiao AWS"
  type = string
  default = "us-east-1"
}

variable "az_subnet_a" {
  description = "AZ da primeira subnet"
  type = string
  default = "a"
}

variable "az_subnet_b" {
  description = "AZ da primeira subnet"
  type = string
  default = "b"
}

variable "nlb_name" {
  description = "Nome do Network Loadbalancer"
  type = string
  default = "NlbMs"
}

variable "ecs_name" {
  description = "Nome do ECS"
  type = string
  default = "EcsMs"
}