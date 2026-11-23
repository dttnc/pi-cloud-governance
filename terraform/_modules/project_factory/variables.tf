variable "project_base_name" {
  description = "Base name of the project without environment suffix (e.g., data-platform, mobile-backend)."
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

variable "apis" {
  description = "List of GCP APIs to enable for this squad's project."
  type        = list(string)
  default     = []
}

variable "sa_roles" {
  description = "List of IAM roles granted to the squad deployer Service Account in this project."
  type        = list(string)
  default     = []
}

variable "labels" {
  description = "Resource labels attached to the project."
  type        = map(string)
  default     = {}
}

variable "squad_email" {
  description = "Google Group email of the squad owning this project."
  type        = string
}

variable "default_region" {
  description = "Default compute region."
  type        = string
  default     = "europe-west1"
}
