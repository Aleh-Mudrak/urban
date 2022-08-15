### Global parametrs
project_id = "taskurban"
region     = "us-central1"
location   = "US"
env        = "prod"


### Service Account
service_account_name = "urban-sa"
sa_display_name      = "Urban Service Account"


### Network
# VPC
google_compute_network_name     = "main"
routing_mode                    = "REGIONAL"
# Subnet
private_subnet           = "private"
# Router
router_name = "router"
# NAT
router_nat_name                    = "nat"
# Firewall
firewall = {
    "open-ports" = {
      protocol = "tcp"
      allow_ports = [
        "80",
        "443"
      ]
      source_ranges = ["0.0.0.0/0"]
    },
    "app-ports" = {
      protocol = "tcp"
      allow_ports = [
        "3000"
      ]
      source_ranges = ["0.0.0.0/0"]
    }
  }


### Kubernetes Cluster
cluster_name                  = "primary"
cluster_location              = "us-central1-a"
node_locations                = ["us-central1-b"]
# Node pool
node_pool = {
  # First Node
    "system" = {
      node_count = 1
      machine_type = "e2-medium"
      labels = {
          lable = "system"
        }
    },
  # Second Node
    "sbox" = {
      node_count = 1
      machine_type = "e2-medium"
      labels = {
          lable = "sbox"
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
