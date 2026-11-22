output "teams" {
  description = "Created GitHub teams and IDs."
  value = {
    for k, v in github_team.teams : k => {
      id   = v.id
      slug = v.slug
    }
  }
}

output "repositories" {
  description = "Created GitHub repositories."
  value = {
    for k, v in github_repository.repos : k => {
      name      = v.name
      full_name = v.full_name
      html_url  = v.html_url
    }
  }
}
