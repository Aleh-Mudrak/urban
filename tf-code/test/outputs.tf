### Main data output
output "project_id" {
  value = var.project_id
}
output "region" {
  value = var.region
}
output "location" {
  value = var.location
}



output "service_account_id" {
  value = local.service_account_id
}