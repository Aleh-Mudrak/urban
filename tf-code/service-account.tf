module "service_account" {
  source = "../modules/service-account"

  name                  = var.gh_service_account_name
  project               = var.project_id
  sa_display_name       = var.gh_sa_display_name
  service_account_roles = var.gh_service_account_roles
}

# Add access to GitHub Service Acount
resource "google_container_node_pool" "primary_preemptible_nodes" {
  node_config {
    service_account = "${module.service_account.email}"

    oauth_scopes = [
      "storage-ro",
      "logging-write",
      "monitoring"
    ]
  }
}