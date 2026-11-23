locals {
  project_id = "${var.project_base_name}-${var.environment}"

  # Core baseline infrastructure & telemetry APIs
  infra_apis = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com"
  ]

  all_apis = distinct(concat(local.infra_apis, var.apis))

  standard_labels = merge(var.labels, {
    environment = var.environment
    managed_by  = "terraform-project-factory"
  })
}

# 1. Standardized GCP Project
resource "google_project" "project" {
  name            = "${var.project_base_name}-${var.environment}"
  project_id      = local.project_id
  folder_id       = var.folder_id
  billing_account = var.billing_account
  labels          = local.standard_labels

  auto_create_network = false # Disable default VPC
}

# 2. Declarative API Enablement
resource "google_project_service" "enabled_apis" {
  for_each = toset(local.all_apis)

  project            = google_project.project.project_id
  service            = each.key
  disable_on_destroy = false
}

# 3. Dedicated Squad Deployer Service Account
resource "google_service_account" "deployer" {
  project      = google_project.project.project_id
  account_id   = "sa-deployer-${var.environment}"
  display_name = "Deployer SA (${var.environment})"
  description  = "Assumed by GitHub Actions via Workload Identity Federation for automated CI/CD deployments."
  depends_on   = [google_project_service.enabled_apis]
}

# 4. Squad Least-Privilege IAM Roles
resource "google_project_iam_member" "sa_roles" {
  for_each = toset(var.sa_roles)

  project = google_project.project.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.deployer.email}"
}
