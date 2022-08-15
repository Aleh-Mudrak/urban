### Network 

# VPC
resource "google_compute_network" "main" {
  project                         = var.project_id
  name                            = var.google_compute_network_name
  routing_mode                    = var.routing_mode
  auto_create_subnetworks         = var.auto_create_subnetworks
  mtu                             = var.mtu
  delete_default_routes_on_create = var.delete_default_routes_on_create
}


# Subnet
resource "google_compute_subnetwork" "private" {
  name                     = var.private_subnet
  project                  = var.project_id
  ip_cidr_range            = var.private_cidr_range
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = var.private_ip_google_access

  secondary_ip_range {
    range_name    = var.range_name_pod
    ip_cidr_range = var.ip_cidr_range_pod
  }
  secondary_ip_range {
    range_name    = var.range_name_service
    ip_cidr_range = var.ip_cidr_range_service
  }
}

# Router
resource "google_compute_router" "router" {
  name    = var.router_name
  project = var.project_id
  region  = var.region
  network = google_compute_network.main.id
}

# NAT
resource "google_compute_router_nat" "nat" {
  project = var.project_id
  name    = var.router_nat_name
  router  = google_compute_router.router.name
  region  = var.region

  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
  nat_ip_allocate_option             = var.nat_ip_allocate_option

  subnetwork {
    name                    = google_compute_subnetwork.private.id
    source_ip_ranges_to_nat = var.source_ip_ranges_to_nat
  }

  nat_ips = [google_compute_address.nat.self_link]
}

resource "google_compute_address" "nat" {
  name         = var.address_nat_name
  project      = var.project_id
  region       = var.region
  address_type = var.address_type
  network_tier = var.network_tier
}

# Firewall
resource "google_compute_firewall" "allow-ssh" {
  for_each = var.firewall

  name    = each.key
  project = var.project_id
  network = google_compute_network.main.name

  allow {
    protocol = lookup(each.value, "protocol", "tcp")
    ports    = each.value.allow_ports
  }

  source_ranges = each.value.source_ranges
}
