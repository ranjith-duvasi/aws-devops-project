aws_region   = "us-east-1"
project_name = "demo"
environment  = "dev"

cluster_version = "1.34"

vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]

node_groups = {
  general = {
    instance_types = ["t3.small"]
    min_size       = 1
    max_size       = 3
    desired_size   = 2
    disk_size_gb   = 20
    labels         = { role = "general" }
    taints         = []
  }
}
