### Deploy Prometheus in Cluster

# Create Kubernetes Namespace
resource "kubernetes_namespace" "metrics" {
  depends_on = [google_container_node_pool.general]
  metadata {
    name = "metrics"
  }
}

# Deploy prometheus
resource "helm_release" "prometheus" {
  depends_on = [google_container_node_pool.general]

  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.metrics.id
}
