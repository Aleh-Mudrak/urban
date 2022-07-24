

# locals {
#   all_service_account_roles = concat(var.service_account_roles)
# }

# resource "google_project_iam_member" "service_account-roles" {
#   for_each = toset(local.all_service_account_roles)

#   project = var.project
#   role    = each.value
#   member  = "serviceAccount:${google_service_account.service_account.email}"
# }

### Creating Kubernetes Namespaces from variable-list
locals {
  all_namespaces = concat(var.app_namespaces)
}

resource "kubernetes_namespace" "app_namespaces" {
  for_each = toset(local.all_namespaces)

  metadata {
    name = each.value
  }
}