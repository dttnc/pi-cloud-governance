variable "project_base_name" {
  description = "Base name of the data project without environment suffix (e.g., data-analytics)."
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, stg, prd)."
  type        = string
}

variable "folder_id" {
  description = "Parent GCP Folder ID (e.g. folders/123456789 or numeric ID)."
  type        = string
}

variable "billing_account" {
  description = "GCP Billing Account ID to link."
  type        = string
}

variable "data_apis" {
  description = "List of GCP Data & AI APIs to enable."
  type        = list(string)
  default = [
    "bigquery.googleapis.com",
    "aiplatform.googleapis.com",
    "storage.googleapis.com",
    "run.googleapis.com",
    "artifactregistry.googleapis.com"
  ]
}

variable "labels" {
  description = "Resource labels attached to the project."
  type        = map(string)
  default     = {}
}

variable "squad_email" {
  description = "Google Group email of the data squad owning this project."
  type        = string
}

variable "default_region" {
  description = "Default compute region."
  type        = string
  default     = "europe-west1"
}
