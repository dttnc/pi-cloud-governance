module "github" {
  source = "../_modules/github_governance"

  teams        = var.github_teams
  repositories = var.github_repositories
}
