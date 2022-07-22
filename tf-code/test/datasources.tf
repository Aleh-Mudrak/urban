
data "terraform_remote_state" "infrustructure" {
  backend = "gcs"
  config = {
    bucket  = "tfstate_files"
    prefix  = "prod"
  }
}

locals {
  service_account_id = data.terraform_remote_state.infrustructure.outputs.service_account_id
}