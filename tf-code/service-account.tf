module "service_account" {
  source = "../modules/service-account"

  name            = var.service_account_name
  project         = var.project_id
  sa_display_name = var.sa_display_name
}



# resource "google_service_account_key" "sa_key" {
#   service_account_id = google_service_account.service_account.name
# }

# resource "local_file" "sa_key" {
#   filename = "../sa_key.raw"
#   content  = "${base64decode(google_service_account_key.gh_sa_key.private_key)}"
# }
