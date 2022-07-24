### Deploy Prometheus in Cluster

# Create Kubernetes Namespace
resource "kubernetes_namespace" "metrics" {
  metadata {
    name = var.prometheus_namespace
  }
}

# Deploy prometheus
resource "helm_release" "prometheus" {
  name       = var.prometheus_name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.metrics.id
}
