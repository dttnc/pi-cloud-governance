variable "project_id" {
  description = "The GCP project ID where the Workload Identity Pool will be created."
  type        = string
}

variable "pool_id" {
  description = "Identifier for the Workload Identity Pool."
  type        = string
  default     = "github-actions-pool"
}

variable "provider_id" {
  description = "Identifier for the GitHub OIDC Provider."
  type        = string
  default     = "github-provider"
}

variable "github_org" {
  description = "The trusted GitHub organization."
  type        = string
}

variable "authorized_repos" {
  description = "List of full repository names (e.g., 'org/repo') allowed to impersonate the target service account."
  type        = list(string)
  default     = []
}

variable "target_service_account_id" {
  description = "The fully qualified ID of the Service Account to be impersonated."
  type        = string
}
