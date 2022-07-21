# Creating Kubernetes Cluster

resource "google_container_cluster" "primary" {
  name                     = var.cluster_name
  project                  = var.project_id
  location                 = var.cluster_location
  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count
  network                  = google_compute_network.main.self_link
  subnetwork               = google_compute_subnetwork.private.self_link
  logging_service          = var.logging_service
  monitoring_service       = var.monitoring_service
  networking_mode          = var.networking_mode

  node_locations = var.node_locations

  addons_config {
    http_load_balancing {
      disabled = var.http_load_balancing
    }
    horizontal_pod_autoscaling {
      disabled = var.horizontal_pod_autoscaling
    }
  }

  release_channel {
    channel = var.release_channel
  }

  workload_identity_config {
    workload_pool = "${lower(var.project_id)}.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  private_cluster_config {
    enable_private_nodes    = var.enable_private_nodes
    enable_private_endpoint = var.enable_private_endpoint
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }
}


### Node Pool

resource "google_service_account" "kubernetes" {
  project      = var.project_id
  account_id   = var.google_service_account_id_kubernetes
  display_name = var.k8s_sa_display_name
}

resource "google_container_node_pool" "general" {
  name       = var.google_container_node_pool_general_name
  project    = var.project_id
  cluster    = google_container_cluster.primary.id
  node_count = var.node_count

  management {
    auto_repair  = var.auto_repair_general
    auto_upgrade = var.auto_upgrade_general
  }

  node_config {
    preemptible  = var.preemptible_general
    machine_type = var.machine_type_general

    labels = {
      role = var.lable_general
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "storage-ro",
      "logging-write",
      "monitoring"
    ]
  }
}

resource "google_container_node_pool" "spot" {
  name    = var.google_container_node_pool_spot_name
  cluster = google_container_cluster.primary.id

  management {
    auto_repair  = var.auto_repair_spot
    auto_upgrade = var.auto_upgrade_spot
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  node_config {
    preemptible  = var.preemptible_spot
    machine_type = var.machine_type_spot

    labels = {
      team = var.lable_spot
    }

    taint {
      key    = "instance_type"
      value  = "spot"
      effect = "NO_SCHEDULE"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "storage-ro",
      "logging-write",
      "monitoring"
    ]
  }
}
