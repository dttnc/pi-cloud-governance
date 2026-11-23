terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.30"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.30"
    }
  }

  backend "gcs" {
    bucket = "dttnc-pi-cloud-governance-tfstate"
    prefix = "gcp/projects"
  }
}

provider "google" {
  project = var.billing_project_id
  region  = var.default_region
}

provider "google-beta" {
  project = var.billing_project_id
  region  = var.default_region
}
