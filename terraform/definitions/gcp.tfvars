# Declarative GCP Multi-Project Data Factory (dev, stg, prd)

billing_account = "012345-6789AB-CDEF01"
default_region  = "europe-west1"
github_org      = "dttnc"

data_projects = {
  # Core Data Platform: Ingestion, Lakehouse & Shared Datasets
  "data-platform" = {
    description  = "Core Data Platform lakehouse, ingestion pipelines, and shared BigQuery datasets"
    squad_email  = "data-platform@company.internal"
    environments = ["dev", "stg", "prd"]

    data_apis = [
      "bigquery.googleapis.com",
      "storage.googleapis.com",
      "run.googleapis.com",
      "artifactregistry.googleapis.com"
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
  #       "run.googleapis.com",
  #       "storage.googleapis.com"
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
