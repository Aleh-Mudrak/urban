# Deploy Prometheus in Cluster

# Use this datasources to access the Terraform account's email for Kubernetes permissions.
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



resource "kubernetes_namespace" "metrics" {
  depends_on = [google_container_node_pool.general]
  metadata {
    name = "metrics"
  }
}

resource "helm_release" "prometheus" {
  depends_on = [google_container_node_pool.general]

  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.metrics.id
}
