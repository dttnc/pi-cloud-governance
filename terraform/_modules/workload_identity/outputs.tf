output "pool_name" {
  description = "The resource name of the Workload Identity Pool."
  value       = google_iam_workload_identity_pool.pool.name
}

output "workload_identity_provider" {
  description = "The full provider resource name for use in google-github-actions/auth."
  value       = "${google_iam_workload_identity_pool.pool.name}/providers/${google_iam_workload_identity_pool_provider.github_provider.workload_identity_pool_provider_id}"
}
