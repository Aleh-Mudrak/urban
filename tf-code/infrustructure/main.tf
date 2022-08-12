# Terraform requarments

terraform {
  required_version = ">= 1.0"

  # Save tfstate files to Google Bucket
  backend "gcs" {
    bucket = "tfstate_files"
    prefix = "infrustructure"
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

# ---------------------------------------------------------------------------------------------------------------------
# PREPARE PROVIDERS
# ---------------------------------------------------------------------------------------------------------------------

provider "google" {
  project = var.project_id
  region  = var.region

  scopes = [
    # Default scopes
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
    "https://www.googleapis.com/auth/devstorage.full_control",

    # Give access to the registry
    "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/service.management.readonly",
    "https://www.googleapis.com/auth/trace.append",

    # Required for google_client_openid_userinfo
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

# Datasources to access the Terraform account's email for Kubernetes permissions.
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
  host = format("https://%s:%d", data.template_file.gke_host_endpoint.rendered, 443) # https://IP_Address:443
  # host                   = data.template_file.gke_host_endpoint.rendered
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
