terraform {

  # Save tfstate files to Google Bucket
  backend "gcs" {
    bucket = "tfstate_files"
    prefix = "prod"
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

  required_version = ">= 1.0"
}

# provider "kubernetes" {
#   config_path = "~/.kube/config"
# }


