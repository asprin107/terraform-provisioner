module "eks" {
  source = "../../_modules/eks/cluster/v1"

  name           = module.naming.name
  eks_subnet_ids = module.network.private_subnet_ids
}

module "addon" {
  source = "../../_modules/eks/addon/v1"

  name                  = module.naming.name
  vpc_id                = module.network.main_vpc_id
  eks_cluster_name      = module.eks.eks_info.cluster_name
  eks_oidc_issuer_url   = module.eks.eks_info.oidc_issuer_url
  eks_oidc_provider_arn = module.eks.eks_info.oidc_provider_arn

  argocd-enabled = true

  aws_load_balancer_controller-enabled      = true
  aws_load_balancer_controller-irsa-enabled = true

  cluster_autoscaler-enabled      = true
  cluster_autoscaler-irsa-enabled = true

  kyverno-enabled      = false
  kyverno-irsa-enabled = false

  external_secrets-enabled      = true
  external_secrets-irsa-enabled = true

  aws_ebs_csi_driver-enabled      = true
  aws_ebs_csi_driver-irsa-enabled = true

  gha_runner_scale_set_controller-enabled      = false
  gha_runner_scale_set_controller-irsa-enabled = false
  gha_config_url                               = var.gha_config_url
  gha_secret_name                              = "gha-secret"

  kube_ops_view-enabled = true

  depends_on = [module.eks]
}