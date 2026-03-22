# main.tf
resource "aws_prometheus_workspace" "monitoring" {
  alias = "eks-observability-workspace"
}

# IAM Role for EKS Service Account (IRSA)
module "prometheus_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "prometheus-ingest-role"

  attach_amazon_managed_service_prometheus_write_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["monitoring:prometheus-sa"]
    }
  }
}
