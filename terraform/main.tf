
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs = ["${var.aws-region}a" , "${var.aws-region}b"]
  public-subnets = ["10.0.1.0/24" , "10.0.2.0/24"]
  private-subnets = ["10.0.3.0/24" , "10.0.4.0/24"]

  enable-nat-gateway = true
  single-nat-gateway = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"


  cluster_name    = "jenkins-demo-cluster"
  cluster_version = "1.29"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets 

  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
    }
  }
}


