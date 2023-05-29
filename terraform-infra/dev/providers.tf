terraform {
  required_version = ">= 1.1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.45.0"
    }

    helm = {
      source  = "helm"
      version = "=2.5.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.16.1"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }

  // store the state in s3 bucket
  backend "s3" {
    bucket                  = "de-dev-trf"
    key                     = "koko/state.tfstate"
    region                  = "eu-central-1"
    shared_credentials_file = "~/.aws/credentials"
  }
}

provider "aws" {
  region = var.region
  shared_credentials_files = [
  pathexpand("~/.aws/credentials")]
  profile = "default"
  shared_config_files = [
  pathexpand("~/.aws/config")]
  assume_role {
    role_arn = var.tf_role_arn
  }
}

provider "kubernetes" {
  host                   = module.eks.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate_authority[0].data)
  token                  = module.eks.eks_cluster_token
  //  load_config_file = false
}

provider "helm" {
  kubernetes {
    host                   = module.eks.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate_authority[0].data)
    token                  = module.eks.eks_cluster_token
  }
}

provider "kubectl" {
  host                   = module.eks.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate_authority[0].data)
  token                  = module.eks.eks_cluster_token
}