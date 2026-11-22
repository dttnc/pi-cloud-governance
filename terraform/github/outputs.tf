output "teams" {
  description = "Created GitHub teams and slugs."
  value       = module.github_governance.teams
}

output "repositories" {
  description = "Created GitHub repositories."
  value       = module.github_governance.repositories
}
