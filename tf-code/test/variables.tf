### General
variable "project_id" {
  description = "The project ID to host the cluster in"
  default     = "taskurban"
}
variable "env" {
  description = "Environment"
  default     = "test"
}
variable "region" {
  description = "The region to host the cluster in"
  default     = "us-central1"
}
variable "location" {
  description = "The location to host the cluster in"
  default     = "US"
}

