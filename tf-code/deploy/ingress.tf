### Deploy Ingress in Cluster

# Create Kubernetes Namespace
resource "kubernetes_namespace" "ingress" {
  metadata {
    name = var.ingress_namespace
  }
}


# Deploy Ingress
resource "helm_release" "ingress" {
  name       = var.ingress_name
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"
  namespace  = kubernetes_namespace.ingress.id
}
