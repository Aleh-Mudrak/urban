### General
variable "project_id" {
  description = "The project ID to host the cluster in"
  default     = "taskurban"
}
variable "env" {
  description = "Environment"
  default     = "test"
}
variable "region" {
  description = "The region to host the cluster in"
  default     = "us-central1"
}
variable "location" {
  description = "The location to host the cluster in"
  default     = "US"
}


### GH Service account
variable "gh_service_account_name" {
  description = "The name of the custom service account used for the GitHub Actions. This parameter is limited to a maximum of 28 characters."
  type        = string
  default     = "urban-sa"
}
variable "gh_sa_display_name" {
  description = "The description of the custom service account."
  type        = string
  default     = ""
}
variable "gh_service_account_roles" {
  description = "Service account roles"
  type        = list(string)
  default     = []
}


### Network
# VPC
variable "google_compute_network_name" {
  description = "Google compute network name"
  type        = string
  default     = ""
}
variable "routing_mode" {
  description = "Routing mode"
  type        = string
  default     = ""
}
variable "auto_create_subnetworks" {
  description = "Auto create subnetworks"
  type        = bool
  default     = false
}
variable "mtu" {
  description = "mtu"
  type        = number
  default     = 1460
}
variable "delete_default_routes_on_create" {
  description = "delete default routes on create"
  type        = bool
  default     = false
}

# Subnet
variable "private_subnet" {
  description = "Private subnet name"
  type        = string
  default     = ""
}
variable "private_cidr_range" {
  description = "Private IP cidr range"
  type        = string
  default     = ""
}
variable "private_ip_google_access" {
  description = "Private IP google access"
  type        = bool
  default     = true
}
variable "range_name_pod" {
  description = "Pod IP cidr range name"
  type        = string
  default     = ""
}
variable "range_name_service" {
  description = "Service IP cidr range name"
  type        = string
  default     = ""
}
variable "ip_cidr_range_pod" {
  description = "Pod IP cidr range"
  type        = string
  default     = ""
}
variable "ip_cidr_range_service" {
  description = "Service IP cidr range"
  type        = string
  default     = ""
}

# Router
variable "router_name" {
  description = "Router name"
  type        = string
  default     = ""
}

# NAT
variable "router_nat_name" {
  description = "router NAT name"
  type        = string
  default     = ""
}
variable "source_subnetwork_ip_ranges_to_nat" {
  description = "Source subnetwork ip ranges to NAT"
  type        = string
  default     = ""
}
variable "nat_ip_allocate_option" {
  description = "NAT ip allocate option"
  type        = string
  default     = ""
}
variable "source_ip_ranges_to_nat" {
  description = "Source IP ranges to NAT"
  type        = list(string)
  default     = []
}
variable "address_nat_name" {
  description = "Address NAT name"
  type        = string
  default     = ""
}
variable "address_type" {
  description = "Address type"
  type        = string
  default     = ""
}
variable "network_tier" {
  description = "Network tier"
  type        = string
  default     = ""
}

# Firewall
variable "firewall_name" {
  description = "Firewall name"
  type        = string
  default     = ""
}
variable "protocol" {
  description = "Protocol TCP or UDP"
  type        = string
  default     = ""
}
variable "allow_ports" {
  description = "Allow ports"
  type        = list(string)
  default     = []
}
variable "source_ranges" {
  description = "Allow source ranges"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


### Kubernetes
variable "cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
  default     = ""
}
variable "cluster_location" {
  description = "Kubernetes available zone"
  type        = string
  default     = ""
}
variable "remove_default_node_pool" {
  description = "Remove default node pool"
  type        = bool
  default     = true
}
variable "initial_node_count" {
  description = "Node count"
  type        = number
  default     = 1
}
variable "logging_service" {
  description = "Logging service"
  type        = string
  default     = ""
}
variable "monitoring_service" {
  description = "Monitoring service"
  type        = string
  default     = ""
}
variable "networking_mode" {
  description = "Networking mode"
  type        = string
  default     = ""
}
variable "node_locations" {
  description = "node_locations"
  type        = list(string)
  default     = []
}
variable "http_load_balancing" {
  description = "Load Balancing"
  type        = bool
  default     = true
}
variable "horizontal_pod_autoscaling" {
  description = "Horizontal Pod Autoscaling"
  type        = bool
  default     = false
}
variable "release_channel" {
  description = "Release channel"
  type        = string
  default     = ""
}
variable "cluster_secondary_range_name" {
  description = "Cluster secondary range name"
  type        = string
  default     = ""
}
variable "services_secondary_range_name" {
  description = "Service secondary range name"
  type        = string
  default     = ""
}
variable "enable_private_nodes" {
  description = "Enable private nodes"
  type        = bool
  default     = true
}
variable "enable_private_endpoint" {
  description = "Enable private endpoint"
  type        = bool
  default     = false
}
variable "master_ipv4_cidr_block" {
  description = "Master cidr block"
  type        = string
  default     = ""
}


### Node pool
variable "google_service_account_id_kubernetes" {
  description = "Kubernetes google service account id "
  type        = string
  default     = ""
}
variable "k8s_sa_display_name" {
  description = "Kubernetes google service account Name "
  type        = string
  default     = ""
}

# General node config
variable "google_container_node_pool_general_name" {
  description = "Name of container node pool"
  type        = string
  default     = ""
}
variable "node_count" {
  description = "Nodes count"
  type        = number
  default     = 1
}
variable "auto_repair_general" {
  description = "Auto repair in general"
  type        = bool
  default     = true
}
variable "auto_upgrade_general" {
  description = "Auto upgrade in general"
  type        = bool
  default     = true
}
variable "preemptible_general" {
  description = "Preemtible"
  type        = bool
  default     = false
}
variable "machine_type_general" {
  description = "Machine type for general"
  type        = string
  default     = ""
}
variable "lable_general" {
  description = "Lable for general"
  type        = string
  default     = ""
}

# Spot nodes config
variable "google_container_node_pool_spot_name" {
  description = "Name of container node pool"
  type        = string
  default     = ""
}
variable "auto_repair_spot" {
  description = "Auto repair in spot"
  type        = bool
  default     = true
}
variable "auto_upgrade_spot" {
  description = "Auto upgrade in spot"
  type        = bool
  default     = true
}
variable "min_node_count" {
  description = "Minimum count of nodes"
  type        = number
  default     = 0
}
variable "max_node_count" {
  description = "Maximum count of nodes"
  type        = number
  default     = 5
}
variable "preemptible_spot" {
  description = "Preemtible"
  type        = bool
  default     = true
}
variable "machine_type_spot" {
  description = "Machine type for spot"
  type        = string
  default     = ""
}
variable "lable_spot" {
  description = "Lable for spot"
  type        = string
  default     = ""
}
