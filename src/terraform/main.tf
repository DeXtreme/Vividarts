terraform {
  required_providers {
    aws = {
      version = "~>5.15.0"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "vivid-test-terraform-backend"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}


resource "aws_s3_bucket" "results" {
  bucket = "vividarts-lambda-result-bucket"
  force_destroy = true
}



resource "aws_eks_cluster" "cluster" {
  name = "vividarts-cluster"
  vpc_config {
    subnet_ids = [for az,subnet in aws_subnet.private: subnet.id]
  }
  role_arn = aws_iam_role.eks_role.arn

  depends_on = [ aws_iam_role_policy_attachment.eks_role ]
}

resource "aws_eks_node_group" "nodes" {
    cluster_name = aws_eks_cluster.cluster.name
    node_group_name = "vividarts-nodes"
    subnet_ids = [for az,subnet in aws_subnet.public: subnet.id]
    node_role_arn = aws_iam_role.eks_node_role.arn
    instance_types = ["t2.micro"]
    
    scaling_config {
      desired_size = 2
      max_size = 3
      min_size = 1
    }
  
}

resource "aws_ecr_repository" "ecr" {
  name = "vividarts"
  force_delete = true
}


