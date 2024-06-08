data "aws_eks_cluster_auth" "cluster" {
name = module.eks_cluster.cluster_name
}
