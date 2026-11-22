# 1. Declarative GitHub Teams / Squads
resource "github_team" "teams" {
  for_each = var.teams

  name        = each.key
  description = each.value.description
  privacy     = each.value.privacy
}

# 2. Standardized GitHub Repositories
resource "github_repository" "repos" {
  for_each = var.repositories

  name                   = each.key
  description            = each.value.description
  visibility             = each.value.visibility
  has_issues             = true
  has_projects           = false
  has_wiki               = false
  auto_init              = false
  delete_branch_on_merge = true
  topics                 = each.value.topics
  # vulnerability_alerts   = true
}

# 3. Flatten team collaborator permissions across repositories
locals {
  team_repo_matrix = flatten([
    for repo_name, repo_data in var.repositories : [
      for team_name, perm in repo_data.team_permissions : {
        key        = "${repo_name}_${team_name}"
        repo_name  = repo_name
        team_name  = team_name
        permission = perm
      }
    ]
  ])
}

# 4. Attach Squads to Repositories with Explicit RBAC (admin, push, pull)
resource "github_team_repository" "team_access" {
  for_each = {
    for item in local.team_repo_matrix : item.key => item
  }

  team_id    = github_team.teams[each.value.team_name].id
  repository = github_repository.repos[each.value.repo_name].name
  permission = each.value.permission
}

# 5. Enterprise Branch Protection on 'main'
resource "github_branch_protection" "main" {
  for_each = var.repositories

  repository_id = github_repository.repos[each.key].node_id
  pattern       = "main"

  enforce_admins = false

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    required_approving_review_count = 1
  }
}
