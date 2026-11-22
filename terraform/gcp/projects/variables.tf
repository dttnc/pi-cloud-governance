variable "billing_project_id" {
  description = "The project ID used for Terraform authentication and admin resources."
  type        = string
  default     = "demo-platform-seed"
}

variable "billing_account" {
  description = "Google Cloud Billing Account ID."
  type        = string
  default     = "01D1B6-CAB19C-A45EEF"
}

variable "folder_id" {
  description = "Parent GCP Folder ID (optional)."
  type        = string
  default     = ""
}

variable "default_region" {
  description = "Default compute region for data workloads."
  type        = string
  default     = "europe-west1"
}

variable "github_org" {
  description = "Target GitHub organization name for Workload Identity Federation."
  type        = string
  default     = "dttnc"
}

variable "data_projects" {
  description = "Declarative definition of GCP Data & Analytics projects."
  type = map(object({
    description  = string
    squad_email  = string
    environments = list(string)
    data_apis = optional(list(string), [
      "bigquery.googleapis.com",
      "aiplatform.googleapis.com",
      "storage.googleapis.com"
    ])
    github_repos = list(string)
    labels       = optional(map(string), {})
  }))
  default = {}
}
