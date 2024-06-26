## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.16 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.ecs_ms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.nginx_ms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.nginx_ms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_lb.nlb_ms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.nlb_ms_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.nginx_ms_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.nginx_ms_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_security_group.nginx_ms_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.sub_ms_a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.sub_ms_b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc_ms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az_subnet_a"></a> [az\_subnet\_a](#input\_az\_subnet\_a) | AZ da primeira subnet | `string` | `"a"` | no |
| <a name="input_az_subnet_b"></a> [az\_subnet\_b](#input\_az\_subnet\_b) | AZ da primeira subnet | `string` | `"b"` | no |
| <a name="input_ecs_name"></a> [ecs\_name](#input\_ecs\_name) | Nome do ECS | `string` | `"EcsMs"` | no |
| <a name="input_nlb_name"></a> [nlb\_name](#input\_nlb\_name) | Nome do Network Loadbalancer | `string` | `"NlbMs"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | Profile para deploy | `string` | `"localstack"` | no |
| <a name="input_region"></a> [region](#input\_region) | Regiao AWS | `string` | `"us-east-1"` | no |

## Outputs

No outputs.
