# terraform-aws-route53-vpc-association-authorization

Terraform module for authorizing a cross-account VPC to associate with a
private Route53 hosted zone this account owns. To create the zone
itself, see
[`terraform-aws-route53-zone`](https://github.com/kn47ytv9mv/terraform-aws-route53-zone).

## Cost

No cost impact of its own.

## Design

Pairs with
[`terraform-aws-route53-zone-association`](https://github.com/kn47ytv9mv/terraform-aws-route53-zone-association),
which performs the actual association — this module only authorizes
it. Only needed for cross-account associations: this module runs under
the provider for the account that owns the private hosted zone,
authorizing a specific VPC in another account; that account then runs
`terraform-aws-route53-zone-association` itself (under its own
provider) to complete the association.

## Usage

```hcl
module "authorization" {
  source = "kn47ytv9mv/route53-vpc-association-authorization/aws"

  providers = { aws = aws.zone_owner }

  zone_id = module.private_zone.zone_id
  vpc_id  = "vpc-0123456789abcdef0"
}

module "association" {
  source = "kn47ytv9mv/route53-zone-association/aws"

  providers = { aws = aws.vpc_owner }

  zone_id = module.private_zone.zone_id
  vpc_id  = "vpc-0123456789abcdef0"

  depends_on = [module.authorization]
}
```

Or directly from this repository:

```hcl
module "authorization" {
  source = "github.com/kn47ytv9mv/terraform-aws-route53-vpc-association-authorization"

  providers = { aws = aws.zone_owner }

  zone_id    = module.private_zone.zone_id
  vpc_id     = "vpc-0123456789abcdef0"
  vpc_region = "eu-west-1"
}
```

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.0 |
| aws | ~> 6.61 |

## Providers

| Name | Version |
|---|---|
| aws | ~> 6.61 |

## Inputs

| Name | Description | Default | Required |
|---|---|---|---|
| zone_id | The ID of the private hosted zone, in this (the zone-owning) account, to authorize an association for. | `null` | no |
| vpc_id | The ID of the VPC, in the other account, to authorize. | `null` | no |
| vpc_region | Region of the VPC to authorize. If null, assumed to be in the same region as this provider. | `null` | no |

## Outputs

| Name | Description |
|---|---|
| id | The ID of the authorization. |

## License

MIT — see [LICENSE.md](LICENSE.md).
