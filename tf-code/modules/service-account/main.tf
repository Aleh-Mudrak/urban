terraform {
  required_version = ">= 1.0"
}

# ----------------------------------------------------------------------------------------------------------------------
# CREATE SERVICE ACCOUNT
# ----------------------------------------------------------------------------------------------------------------------
resource "google_service_account" "service_account" {
  project      = var.project
  account_id   = var.name
  display_name = var.sa_display_name
}

# ----------------------------------------------------------------------------------------------------------------------
# ADD ROLES TO SERVICE ACCOUNT
# ----------------------------------------------------------------------------------------------------------------------
locals {
  all_service_account_roles = concat(var.service_account_roles)
}

resource "google_project_iam_member" "service_account-roles" {
  for_each = toset(local.all_service_account_roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.service_account.email}"
}


# ----------------------------------------------------------------------------------------------------------------------
# CREATE SERVICE KEY
# ----------------------------------------------------------------------------------------------------------------------

resource "google_service_account_key" "sa_key" {
  service_account_id = google_service_account.service_account.name
}
