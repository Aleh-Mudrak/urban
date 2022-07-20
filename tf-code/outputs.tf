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


### Network output
# output "network" {
#   value = var.network
# }
# output "subnetwork" {
#   value = var.subnetwork
# }
# output "ip_range_pods_name" {
#   description = "The secondary IP range used for pods"
#   value       = var.ip_range_pods_name
# }
# output "ip_range_services_name" {
#   description = "The secondary IP range used for services"
#   value       = var.ip_range_services_name
# }


### GKE output
# output "gke_location" {
#   value = module.gke.location
# }
# output "gke_zones" {
#   description = "List of zones in which the cluster resides"
#   value       = module.gke.zones
# }
# output "master_kubernetes_version" {
#   description = "The master Kubernetes version"
#   value       = module.gke.master_version
# }
# output "kubernetes_endpoint" {
#   description = "The cluster endpoint"
#   sensitive   = true
#   value       = module.gke.endpoint
# }
# output "ca_certificate" {
#   description = "The cluster ca certificate (base64 encoded)"
#   value       = module.gke.ca_certificate
#   sensitive   = true
# }
# output "service_account" {
#   description = "The default service account used for running nodes."
#   value       = module.gke.service_account
# }
# output "cluster_name" {
#   description = "Cluster name"
#   value       = module.gke.name
# }
# output "network_name" {
#   description = "The name of the VPC being created"
#   value       = module.gcp-network.network_name
# }
# output "subnet_name" {
#   description = "The name of the subnet being created"
#   value       = module.gcp-network.subnets_names
# }
# output "subnet_secondary_ranges" {
#   description = "The secondary ranges associated with the subnet"
#   value       = module.gcp-network.subnets_secondary_ranges
# }
# output "peering_name" {
#   description = "The name of the peering between this cluster and the Google owned VPC."
#   value       = module.gke.peering_name
# }
# output "client_token" {
#   description = "The bearer token for auth"
#   sensitive   = true
#   value       = base64encode(data.google_client_config.default.access_token)
# }
