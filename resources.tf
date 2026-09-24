resource "aws_route53_vpc_association_authorization" "resource" {
  zone_id    = var.zone_id
  vpc_id     = var.vpc_id
  vpc_region = var.vpc_region
}

output "id" {
  description = "The ID of the authorization."
  value       = aws_route53_vpc_association_authorization.resource.id
}
