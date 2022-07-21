module "service_account" {
  source = "../modules/service-account"

  name                  = var.gh_service_account_name
  project               = var.project_id
  sa_display_name       = var.gh_sa_display_name
  service_account_roles = var.gh_service_account_roles
}
