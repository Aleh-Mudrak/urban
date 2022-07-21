# GKE Service Account Module

The GKE Service Account module is used to create a GCP service account for use with a GKE cluster. 

## Create custom Service Account

Example tf-code

```t
module "service_account" {
  source = "../modules/service-account"

  name                  = var.gh_service_account_name
  project               = var.project_id
  sa_display_name       = var.gh_sa_display_name
  service_account_roles = var.gh_service_account_roles
}
```

Where

*  Service Account Name `gh_service_account_name`
*  Dispalay Name `gh_sa_display_name`
*  Add Roles `gh_service_account_roles`

```bash
gh_service_account_name = "gh-actions-sa"
gh_sa_display_name      = "GitHub Service Account"
gh_service_account_roles = [
  "roles/container.admin",
  "roles/storage.admin",
  "roles/container.clusterViewer"
]
```

## Output information

* Service Account email address `email`
* Account ID `account_id`
* Service Account Key `sa_key`



