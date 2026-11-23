# Declarative GCP Multi-Project Factory

org_id          = "149483480559"
billing_account = "01D1B6-CAB19C-A45EEF"
default_region  = "europe-west1"
github_org      = "dttnc"

# Declarative Projects across Squad Folders
projects = {
  # Core Data Platform: Ingestion, Lakehouse & Shared Datasets
  "dttnc-data-platform" = {
    folder      = "data"
    description = "Core Data Platform (Ingestion pipelines, shared BigQuery datasets etc)"
    squad_email = "data-platform@company.internal"
    environments = [
      "dev",
      #  "stg"
      # "...",
    ]

    apis = [
      "bigquery.googleapis.com",
      #   "...."
      #   "...."
    ]

    sa_roles = [
      "roles/bigquery.dataEditor",
      "roles/bigquery.jobUser",
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
