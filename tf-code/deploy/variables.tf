# Backend
variable "bucket" {
  description = "Infrustructure Bucket"
  type        = string
  default     = "tfstate_files"
}
variable "prefix" {
  description = "Infrustructure Bucket prefix"
  type        = string
  default     = "infrustructure"
}

# Ingress
variable "ingress_name" {
  description = "Ingress name"
  type        = string
  default     = "main"
}
variable "ingress_namespace" {
  description = "Ingress namespace"
  type        = string
  default     = "ingress"
}

# Prometheus
variable "prometheus_name" {
  description = "prometheus name"
  type        = string
  default     = "prometheus"
}
variable "prometheus_namespace" {
  description = "prometheus namespace"
  type        = string
  default     = "metrics"
}

# Namespaces
variable "app_namespaces" {
  description = "Creating Kubernetes Namespaces from variable-list."
  type        = list(string)
  default = [
    "prod",
    "dev",
    "test"
  ]
}
