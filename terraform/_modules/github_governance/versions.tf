terraform {
  required_version = ">= 1.5.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
  backend "gcs" {
    bucket = "dttnc-pi-cloud-governance-tfstate"
    prefix = "github"
  }
}
