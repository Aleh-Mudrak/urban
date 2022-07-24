# Backend
bucket = "tfstate_files"
prefix = "infrustructure"

# Kubernetes Namespaces
app_namespaces = [
  "prod",
  "dev",
  "test"
]

# Ingress
ingress_name      = "main"
ingress_namespace = "ingress"

# Prometheus
prometheus_name      = "prometheus"
prometheus_namespace = "metrics"
