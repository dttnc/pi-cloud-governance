# Declarative GCP Multi-Project Factory

org_id          = "149483480559"
billing_account = "01D1B6-CAB19C-A45EEF"
default_region  = "europe-west1"
github_org      = "dttnc"

# 1. Data Squad Projects (Folder: "data")
data_projects = {
  # Core Data Platform: Ingestion, Lakehouse & Shared Datasets
  "data-platform" = {
    folder      = "data"
    description = "Core Data Platform lakehouse, ingestion pipelines, and shared BigQuery datasets"
    squad_email = "data-platform@company.internal"
    environments = [
      "dev",
      #  "stg"
      # "...",
    ]

    data_apis = [
      "bigquery.googleapis.com",
      #   "...."
      #   "...."
    ]

    github_repos = [
      "dttnc/pi-cloud-governance",
      "dttnc/data-pipeline"
    ]

    labels = {
      domain      = "data-platform"
      cost_center = "platform-eng"
    }
  }

  #   # Analytics & MLOps Platform: Serving, Marts & Model Training
  #   "data-analytics" = {
  #     description  = "Data modeling, BigQuery analytics marts, and Vertex AI model training"
  #     squad_email  = "data-analytics@company.internal"
  #     environments = ["dev", "stg", "prd"]

  #     data_apis = [
  #       "bigquery.googleapis.com",
  #       "aiplatform.googleapis.com",
  #     ]

  #     github_repos = [
  #       "dttnc/pi-cloud-governance",
  #       "dttnc/data-pipeline"
  #     ]

  #     labels = {
  #       domain      = "analytics"
  #       cost_center = "data-science"
  #     }
  #   }
}
