resource "random_id" "suffix" {
  byte_length = 3
}

locals {
  project_id = "${var.project_base_name}-${var.environment}-${random_id.suffix.hex}"

  # Core infrastructure & telemetry APIs
  infra_apis = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com"
  ]

  all_apis = distinct(concat(local.infra_apis, var.data_apis))

  standard_labels = merge(var.labels, {
    environment  = var.environment
    managed_by   = "terraform-data-factory"
    service_type = "data-platform"
  })
}

# 1. Standardized GCP Data Project
resource "google_project" "project" {
  name            = "${var.project_base_name}-${var.environment}"
  project_id      = local.project_id
  folder_id       = var.folder_id != "" ? var.folder_id : null
  billing_account = var.billing_account
  labels          = local.standard_labels

  auto_create_network = false # Disable default VPC for security compliance
}

# 2. Declarative Data & AI API Enablement
resource "google_project_service" "enabled_apis" {
  for_each = toset(local.all_apis)

  project            = google_project.project.project_id
  service            = each.key
  disable_on_destroy = false
}

# 3. Dedicated Data Pipeline Deployer Service Account
resource "google_service_account" "data_deployer" {
  project      = google_project.project.project_id
  account_id   = "sa-data-deployer-${var.environment}"
  display_name = "Data Pipeline Deployer SA (${var.environment})"
  description  = "Assumed by GitHub Actions via Workload Identity Federation for data pipeline deployments."
  depends_on   = [google_project_service.enabled_apis]
}

# 4. Data-Specific Least-Privilege IAM Roles
resource "google_project_iam_member" "data_roles" {
  for_each = toset([
    "roles/bigquery.dataEditor",
    "roles/bigquery.jobUser",
    "roles/storage.objectAdmin",
    "roles/aiplatform.user",
    "roles/run.developer",
    "roles/viewer"
  ])

  project = google_project.project.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.data_deployer.email}"
}

# 5. Human Squad Member Access (Reader on prd, Editor on dev)
resource "google_project_iam_member" "squad_access" {
  project = google_project.project.project_id
  role    = var.environment == "prd" ? "roles/viewer" : "roles/editor"
  member  = "group:${var.squad_email}"
}
