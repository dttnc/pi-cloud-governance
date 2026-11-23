output "project_id" {
  description = "The globally unique GCP Project ID."
  value       = google_project.project.project_id
}

output "project_number" {
  description = "The numeric project identifier."
  value       = google_project.project.number
}

output "deployer_sa_email" {
  description = "The email of the squad deployer service account."
  value       = google_service_account.deployer.email
}

output "deployer_sa_id" {
  description = "The fully qualified ID of the squad deployer service account."
  value       = google_service_account.deployer.id
}
