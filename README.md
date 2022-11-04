## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../aws-vpc-network | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.app-web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.elb_web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_version"></a> [api\_version](#input\_api\_version) | build version from containers | `string` | `"latest"` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | app name to be deployed | `string` | `"flask-api"` | no |
| <a name="input_app_port"></a> [app\_port](#input\_app\_port) | app port to be served | `string` | `"443"` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | [Optional] A list of Availability zones to operate in. | `list(string)` | <pre>[<br>  "a",<br>  "b",<br>  "c"<br>]</pre> | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | `"eu-west-1"` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Database port to be used | `string` | `"443"` | no |
| <a name="input_enable_private_internet_access"></a> [enable\_private\_internet\_access](#input\_enable\_private\_internet\_access) | [Optional] Should non-public instance be able to access the Internet via a NAT instance. | `bool` | `true` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type | `string` | `"t1.micro"` | no |
| <a name="input_network_bits"></a> [network\_bits](#input\_network\_bits) | [Optional] The number of network bits to be allocated | `number` | `8` | no |
| <a name="input_network_cidr_range"></a> [network\_cidr\_range](#input\_network\_cidr\_range) | [Optional] The Primary Region to run operations and build within. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnets to deploy into | `any` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | [Optional] Extra Tags to add to your stack. | `map` | <pre>{<br>  "enviroment": "alpha"<br>}</pre> | no |
| <a name="input_tiers"></a> [tiers](#input\_tiers) | [Optional] How many uniform tiers to create, use 'public' to create a public tier. | `list(string)` | <pre>[<br>  "public",<br>  "data",<br>  "mid"<br>]</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID for VPC if not provided one will be created | `any` | `null` | no |

## Outputs

No outputs.
