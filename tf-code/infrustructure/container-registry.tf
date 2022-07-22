# Creating Google Container Registry

resource "google_container_registry" "registry" {
  project  = var.project_id
  location = var.location
}

resource "google_storage_bucket_iam_member" "viewer" {
  bucket = google_container_registry.registry.id
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${module.service_account.email}"
}
