module "service_account" {
  source = "../modules/service-account"

  name                  = var.service_account_name
  project               = var.project_id
  sa_display_name       = var.sa_display_name
  service_account_roles = var.service_account_roles
}
