### Global parametrs
project_id = "taskurban"
region     = "us-central1"
location   = "US"
env        = "prod"


### Service Account
gh_service_account_name = "gh-actions-sa"
gh_sa_display_name      = "GitHub Service Account"
gh_service_account_roles = [
  "roles/container.admin",
  "roles/storage.admin",
  "roles/container.clusterViewer"
]

### Network
# VPC
google_compute_network_name     = "main"
routing_mode                    = "REGIONAL"
auto_create_subnetworks         = false
mtu                             = "1460"
delete_default_routes_on_create = false

# Subnet
private_subnet           = "private"
private_cidr_range       = "10.0.0.0/18"
private_ip_google_access = true
range_name_pod           = "pod-range"
range_name_service       = "service-range"
ip_cidr_range_pod        = "10.1.0.0/16"
ip_cidr_range_service    = "10.2.0.0/20"

# Router
router_name = "router"

# NAT
router_nat_name                    = "nat"
source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
nat_ip_allocate_option             = "MANUAL_ONLY"
source_ip_ranges_to_nat            = ["ALL_IP_RANGES"]
address_nat_name                   = "nat"
address_type                       = "EXTERNAL"
network_tier                       = "PREMIUM"

# Firewall
firewall_name = "allow-ssh"
protocol      = "tcp"
allow_ports   = ["22"]
source_ranges = ["0.0.0.0/0"]


### Kubernetes
cluster_name                  = "primary"
cluster_location              = "us-central1-a"
remove_default_node_pool      = true
initial_node_count            = 1
logging_service               = "logging.googleapis.com/kubernetes"
monitoring_service            = "monitoring.googleapis.com/kubernetes"
networking_mode               = "VPC_NATIVE"
node_locations                = ["us-central1-b"]
http_load_balancing           = true
horizontal_pod_autoscaling    = false
release_channel               = "REGULAR"
cluster_secondary_range_name  = "pod-range"
services_secondary_range_name = "service-range"
enable_private_nodes          = true
enable_private_endpoint       = false
master_ipv4_cidr_block        = "172.16.0.0/28"

# Node-pools
google_service_account_id_kubernetes = "kubernetes"
k8s_sa_display_name                  = "Kubernetes Cluster account"
# General node config
google_container_node_pool_general_name = "general"
node_count                              = 1
auto_repair_general                     = true
auto_upgrade_general                    = true
preemptible_general                     = false
machine_type_general                    = "e2-medium"
lable_general                           = "general"
# Spot nodes config
google_container_node_pool_spot_name = "spot"
auto_repair_spot                     = true
auto_upgrade_spot                    = true
min_node_count                       = 0
max_node_count                       = 3
preemptible_spot                     = true
machine_type_spot                    = "e2-medium"
lable_spot                           = "devops"

