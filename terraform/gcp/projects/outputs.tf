output "folders" {
  description = "Created squad folders under the organization."
  value = {
    for k, v in google_folder.folders : k => {
      id           = v.folder_id
      name         = v.name
      display_name = v.display_name
    }
  }
}

output "projects" {
  description = "Provisioned GCP Projects and Deployer Service Accounts across dev, stg, prd."
  value = {
    for k, v in module.projects : k => {
      project_id        = v.project_id
      project_number    = v.project_number
      deployer_sa_email = v.deployer_sa_email
    }
  }
}

output "keyless_deployment_configs" {
  description = "Workload Identity Provider paths for GitHub Actions workflows."
  value = {
    for k, v in module.workload_identity : k => {
      workload_identity_provider = v.workload_identity_provider
      service_account_email      = module.projects[k].deployer_sa_email
    }
  }
}
