output "cluster_name" {
    value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
    value = aws_eks_cluster.this.endpoint
}

output "cluster_ca_cert" {
    value = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_version" {
    value = aws_eks_cluster.this.version
}

output "oidc_issuer_url" {
    value = aws_eks_cluster.this.identity[0].oidc[0].issuer
}
