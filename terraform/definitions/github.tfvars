# Declarative GitHub Organization Governance: Teams & Repositories as Code

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
  "ml-engineering" = {
    description = "Machine Learning Engineering & Model Serving squad"
    privacy     = "closed"
  }
}

# 2. GitHub Repositories & Squad Permissions as Code
github_repositories = {
  "data-pipeline" = {
    description = "ETL pipeline and feature transformation service for BigQuery & Vertex AI"
    visibility  = "public"
    topics      = ["data-engineering", "bigquery", "vertex-ai", "python"]
    team_permissions = {
      "data-platform"  = "admin" # Squad 1: Admin
      "data-analytics" = "push"  # Squad 2: Push (Write)
    }
  }

  "ml-recommender-service" = {
    description = "Recommendation model training and inference service on Vertex AI"
    visibility  = "public"
    topics      = ["machine-learning", "vertex-ai", "python", "model-serving"]
    team_permissions = {
      "ml-engineering" = "admin"
      "data-analytics" = "push"
      "data-platform"  = "pull"
    }
  }
}
