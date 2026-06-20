# -- EKS Cluster ---------------------------------------------------------------
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids             = var.public_subnet_ids
    endpoint_public_access = true
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  # Enable control-plane logging
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  tags = { Name = var.cluster_name }
}

# -- Managed Node Groups -------------------------------------------------------
resource "aws_eks_node_group" "this" {
  for_each = var.node_groups

  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-${each.key}"
  version         = var.cluster_version
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.public_subnet_ids
  instance_types  = each.value.instance_types
  disk_size       = each.value.disk_size_gb

  scaling_config {
    min_size     = each.value.min_size
    max_size     = each.value.max_size
    desired_size = each.value.desired_size
  }

  update_config {
    max_unavailable = 1
  }

  labels = each.value.labels

  dynamic "taint" {
    for_each = each.value.taints
    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = { Name = "${var.cluster_name}-${each.key}" }
}

# -- EKS Add-ons ----------------------------------------------------------------
locals {
  addons = {
    coredns    = "v1.13.2-eksbuild.4"
    kube-proxy = "v1.35.3-eksbuild.2"
    vpc-cni    = "v1.21.1-eksbuild.1"
    #aws-ebs-csi-driver = "v1.60.1-eksbuild.1"
  }
}

resource "aws_eks_addon" "this" {
  for_each = local.addons

  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = each.key
  addon_version               = each.value #commit this if don't want pin versiobs
  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [aws_eks_node_group.this]
}
