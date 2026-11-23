variable "project_id" {
  type        = string
  description = "The target GCP Project ID hosting the BigQuery dataset."
}

variable "dataset_id" {
  type        = string
  description = "The Dataset ID of the BigQuery dataset."
}

variable "roles" {
  type        = list(string)
  description = "The IAM roles to be assigned to the members on this dataset."
}

variable "members" {
  type        = list(string)
  description = "A list of principals (user:, serviceAccount:, group:)."
}
