### Deploy Ingress in Cluster

# Create Kubernetes Namespace
resource "kubernetes_namespace" "ingress" {
  depends_on = [google_container_node_pool.general]
  metadata {
    name = "ingress"
  }
}

# Deploy Ingress
resource "helm_release" "ingress" {
  depends_on = [google_container_node_pool.general]

  name       = "main"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "nginx-stable/nginx-ingress"
  namespace  = kubernetes_namespace.ingress.id
}
