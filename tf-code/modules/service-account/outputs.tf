output "email" {
  description = "The email address of the custom service account."
  value       = google_service_account.service_account.email
}

output "account_id" {
  description = "The account_id of the custom service account."
  value       = google_service_account.service_account.account_id
}

output "sa_key" {
  description = "Service Account Key."
  value       = "${base64decode(google_service_account_key.sa_key.private_key)}"
}
