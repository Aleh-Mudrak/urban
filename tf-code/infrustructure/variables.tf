### General
variable "project_id" {
  description = "The project ID to host the cluster in"
  default     = "taskurban"
}
variable "env" {
  description = "Environment"
  default     = "prod"
}
variable "region" {
  description = "The region to host the cluster in"
  default     = "us-central1"
}
variable "location" {
  description = "The location to host the cluster in"
  default     = "US"
}


### Service account
variable "service_account_name" {
  description = "The name of the custom service account."
  type        = string
  default     = "urban-sa"
}
variable "sa_display_name" {
  description = "The description of the custom service account."
  type        = string
  default     = "Urban Service Account"
}
variable "service_account_roles" {
  description = "Service account roles"
  type        = list(string)
  default = [
    "roles/container.admin",
    "roles/storage.admin",
    "roles/storage.objectViewer",
    "roles/container.clusterViewer"
  ]
}


### Network
# VPC
variable "google_compute_network_name" {
  description = "Google compute network name"
  type        = string
  default     = "main"
}
variable "routing_mode" {
  description = "Routing mode"
  type        = string
  default     = "REGIONAL"
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
  default     = "private"
}
variable "private_cidr_range" {
  description = "Private IP cidr range"
  type        = string
  default     = "10.0.0.0/18"
}
variable "private_ip_google_access" {
  description = "Private IP google access"
  type        = bool
  default     = true
}
variable "range_name_pod" {
  description = "Pod IP cidr range name"
  type        = string
  default     = "pod-range"
}
variable "range_name_service" {
  description = "Service IP cidr range name"
  type        = string
  default     = "service-range"
}
variable "ip_cidr_range_pod" {
  description = "Pod IP cidr range"
  type        = string
  default     = "10.1.0.0/16"
}
variable "ip_cidr_range_service" {
  description = "Service IP cidr range"
  type        = string
  default     = "10.2.0.0/20"
}

# Router
variable "router_name" {
  description = "Router name"
  type        = string
  default     = "router"
}

# NAT
variable "router_nat_name" {
  description = "router NAT name"
  type        = string
  default     = "nat"
}
variable "source_subnetwork_ip_ranges_to_nat" {
  description = "Source subnetwork ip ranges to NAT"
  type        = string
  default     = "LIST_OF_SUBNETWORKS"
}
variable "nat_ip_allocate_option" {
  description = "NAT ip allocate option"
  type        = string
  default     = "MANUAL_ONLY"
}
variable "source_ip_ranges_to_nat" {
  description = "Source IP ranges to NAT"
  type        = list(string)
  default     = ["ALL_IP_RANGES"]
}
variable "address_nat_name" {
  description = "Address NAT name"
  type        = string
  default     = "nat"
}
variable "address_type" {
  description = "Address type"
  type        = string
  default     = "EXTERNAL"
}
variable "network_tier" {
  description = "Network tier"
  type        = string
  default     = "PREMIUM"
}

# Firewall
variable "firewall" {
  description = "Firewall variables"
  type        = any
  default     = {
    "open-ports" = {
      protocol = "tcp"
      allow_ports = [
        "80",
        "443",
        "3000"
      ]
      source_ranges = ["0.0.0.0/0"]
    }
  }
}


### Kubernetes Cluster
variable "cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
  default     = "primary"
}
variable "cluster_location" {
  description = "Kubernetes available zone"
  type        = string
  default     = "us-central1-a"
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
  default     = "logging.googleapis.com/kubernetes"
}
variable "monitoring_service" {
  description = "Monitoring service"
  type        = string
  default     = "monitoring.googleapis.com/kubernetes"
}
variable "networking_mode" {
  description = "Networking mode"
  type        = string
  default     = "VPC_NATIVE"
}
variable "node_locations" {
  description = "node_locations"
  type        = list(string)
  default     = ["us-central1-b"]
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
  default     = "REGULAR"
}
variable "cluster_secondary_range_name" {
  description = "Cluster secondary range name"
  type        = string
  default     = "pod-range"
}
variable "services_secondary_range_name" {
  description = "Service secondary range name"
  type        = string
  default     = "service-range"
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
  default     = "172.16.0.0/28"
}


### Node pool
variable "node_pool" {
  description = "Node pool variables"
  type        = any
  default = {

    # First Node
    "system" = {
      node_count = 1
      machine_type = "e2-medium"
      labels = {
        label = "system"
      }
    },

    # Second Node
    "spot" = {
      node_count = 1
      # management
      auto_repair  = true
      auto_upgrade = true
      # autoscaling
      min_node_count = 1
      max_node_count = 2
      # node_config
      preemptible = false
      machine_type = "e2-medium"
      labels = {
        label = "spot"
      }
      taint = [
        {
          key    = "dedicated"
          value  = "sbox"
          effect = "NO_SCHEDULE"
        }
      ]
    }
  }
}

variable "oauth_scopes" {
  description = "oauth_scopes"
  type        = list(string)
  default = [
    "https://www.googleapis.com/auth/cloud-platform",
    "storage-ro",
    "logging-write",
    "monitoring"
  ]
}
