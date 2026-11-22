# ==============================================================================
# Declarative GitHub Organization Governance: Teams & Repositories as Code
# ==============================================================================

github_org = "dttnc"

# 1. GitHub Squads / Teams as Code
github_teams = {
  "data-platform" = {
    description = "Core Data Platform & Infrastructure Engineering squad"
    privacy     = "closed"
  }
  "data-analytics" = {
    description = "Data Analytics & Machine Learning squad"
    privacy     = "closed"
  }
}

# 2. GitHub Repositories & Squad Permissions as Code
github_repositories = {
  "pi-cloud-governance" = {
    description = "Declarative GitOps repository for GCP projects, IAM, and GitHub governance"
    visibility  = "public"
    topics      = ["terraform", "gitops", "gcp-governance", "wif"]
    team_permissions = {
      "data-platform"  = "admin"
      "data-analytics" = "pull"
    }
  }
  "data-pipeline" = {
    description = "ETL pipeline and feature transformation service for BigQuery & Vertex AI"
    visibility  = "public"
    topics      = ["data-engineering", "bigquery", "vertex-ai", "python"]
    team_permissions = {
      "data-platform"  = "admin" # Squad 1: Admin
      "data-analytics" = "push"  # Squad 2: Push (Write)
    }
  }
}
