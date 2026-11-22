variable "teams" {
  description = "Map of GitHub teams/squads to create."
  type = map(object({
    description = string
    privacy     = optional(string, "closed")
  }))
  default = {}
}

variable "repositories" {
  description = "Map of repositories and their squad collaborator permissions."
  type = map(object({
    description      = string
    visibility       = optional(string, "public")
    topics           = optional(list(string), ["data", "gcp", "gitops"])
    team_permissions = map(string) # team_key => permission ("pull", "push", "admin")
  }))
  default = {}
}
