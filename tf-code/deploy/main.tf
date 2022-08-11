terraform {
  required_version = ">= 1.0"

  # Save tfstate files to Google Bucket
  backend "gcs" {
    bucket = "tfstate_files"
    prefix = "deploy"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.3"
    }
  }

}

# Get data from remote tfstate file

data "terraform_remote_state" "deploy" {
  backend = "gcs"
  config = {
    bucket = var.bucket # "tfstate_files"
    prefix = var.prefix # "deploy"
  }
}

# Get variables from deploy tfstate file
locals {
  project_id                 = data.terraform_remote_state.deploy.outputs.project_id
  region                     = data.terraform_remote_state.deploy.outputs.region
  service_account_id         = data.terraform_remote_state.deploy.outputs.service_account_id
  gke_endpoint               = data.terraform_remote_state.deploy.outputs.gke_endpoint
  gke_access_token           = data.terraform_remote_state.deploy.outputs.gke_access_token
  gke_cluster_ca_certificate = data.terraform_remote_state.deploy.outputs.gke_cluster_ca_certificate
}

provider "kubernetes" {
  host                   = format("https://%s:%d", local.gke_endpoint, 443)
  token                  = local.gke_access_token
  cluster_ca_certificate = local.gke_cluster_ca_certificate
}

provider "helm" {

  kubernetes {
    host                   = local.gke_endpoint
    token                  = local.gke_access_token
    cluster_ca_certificate = local.gke_cluster_ca_certificate
  }
}
