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

# Use this datasource to access the Terraform account's email for Kubernetes permissions.
data "google_client_config" "kubernetes" {}
data "google_client_openid_userinfo" "terraform_user" {}
data "template_file" "gke_host_endpoint" {
  template = google_container_cluster.primary.endpoint
}
data "template_file" "access_token" {
  template = data.google_client_config.kubernetes.access_token
}
data "template_file" "cluster_ca_certificate" {
  template = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}

provider "kubernetes" {

  host                   = data.template_file.gke_host_endpoint.rendered
  token                  = data.template_file.access_token.rendered
  cluster_ca_certificate = data.template_file.cluster_ca_certificate.rendered
}

provider "helm" {

  kubernetes {
    host                   = data.template_file.gke_host_endpoint.rendered
    token                  = data.template_file.access_token.rendered
    cluster_ca_certificate = data.template_file.cluster_ca_certificate.rendered
  }
}

