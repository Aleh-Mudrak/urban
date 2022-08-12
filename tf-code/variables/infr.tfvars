### Global parametrs
project_id = "taskurban"
region     = "us-central1"
location   = "US"
env        = "prod"


### Service Account
service_account_name = "urban-sa"
sa_display_name      = "Urban Service Account"
service_account_roles = [
  "roles/container.admin",
  "roles/storage.admin",
  "roles/storage.objectViewer",
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
firewall_name = "allow-ports"
protocol      = "tcp"
allow_ports = [
  "80",
  "443",
  "3000"
]
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

# Node pool
node_pool = {

  # First Node
    "system" : {
      node_count : 1
      # management
      auto_repair  = true
      auto_upgrade = true
      # autoscaling
      min_node_count = 1
      max_node_count = 2
      # node_config
      preemptible : false
      machine_type : "e2-medium"
      labels : {
          lable = "system"
        }
      taint = []
    },

  # Second Node
    "sbox" : {
      node_count : 1
      # management
      auto_repair  = true
      auto_upgrade = true
      # autoscaling
      min_node_count = 1
      max_node_count = 2
      # node_config
      preemptible : false
      machine_type : "e2-medium"
      labels : {
          lable : "sbox"
        }
      taint = [
        {
          key      = "dedicated"
          value    = "sbox"
          effect   = "NO_SCHEDULE"
        }
      ]
    }
  }
