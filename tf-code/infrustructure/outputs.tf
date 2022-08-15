### Main data output
output "project_id" {
  value = var.project_id
}
output "region" {
  value = var.region
}
output "location" {
  value = var.location
}


### Service service_account output
output "service_account_id" {
  value = module.service_account.account_id
}
output "service_account_email" {
  value = module.service_account.email
}
output "service_account_sa_key" {
  value     = module.service_account.sa_key
  sensitive = true
}


### GKE output
output "cluster_name" {
  value = var.cluster_name
}
output "cluster_location" {
  value = var.cluster_location
}
output "gke_master_version" {
  description = "The Kubernetes master version."
  value       = google_container_cluster.primary.master_version
}
output "gke_endpoint" {
  description = "The IP address of the cluster master."
  value       = google_container_cluster.primary.endpoint
}

# The following outputs allow authentication and connectivity to the GKE Cluster.
output "gke_client_certificate" {
  description = "Public certificate used by clients to authenticate to the cluster endpoint."
  sensitive   = true
  value       = base64decode(google_container_cluster.primary.master_auth[0].client_certificate)
}
output "gke_client_key" {
  description = "Private key used by clients to authenticate to the cluster endpoint."
  sensitive   = true
  value       = base64decode(google_container_cluster.primary.master_auth[0].client_key)
}
output "gke_cluster_ca_certificate" {
  description = "The public certificate that is the root of trust for the cluster."
  sensitive   = true
  value       = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}
output "gke_access_token" {
  description = "Access token."
  sensitive   = true
  value       = data.template_file.access_token.rendered
}
