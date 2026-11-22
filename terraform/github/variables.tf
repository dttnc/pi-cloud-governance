variable "github_org" {
  description = "Target GitHub organization name."
  type        = string
  default     = "dttnc"
}

variable "github_teams" {
  description = "Declarative definition of GitHub squads/teams."
  type = map(object({
    description = string
    privacy     = optional(string, "closed")
  }))
  default = {}
}

variable "github_repositories" {
  description = "Declarative definition of GitHub repositories and squad access permissions."
  type = map(object({
    description      = string
    visibility       = optional(string, "public")
    topics           = optional(list(string), ["data", "gcp", "gitops"])
    team_permissions = map(string) # team_name => "admin" | "push" | "pull"
  }))
  default = {}
}


# variable "data_squad_team_names" {
#   description = "List of data squad team names to create." # <--- CRITICAL FOR THE AUTOMATION
#   type        = list(string)
# }

# variable "data_squad_repo_names" {
#   description = "List of data squad repository names to create." # <--- CRITICAL FOR THE AUTOMATION
#   type        = list(string)
# }

# variable "data_squad_repo_description" {
#   description = "Common description for data squad repositories." # <--- CRITICAL FOR THE AUTOMATION
#   type        = string
#   default     = "Data Squad Repository"
# }

# variable "admin_team_name" {
#   description = "Name of the admin team for repository access." # <--- CRITICAL FOR THE AUTOMATION
#   type        = string
# }
