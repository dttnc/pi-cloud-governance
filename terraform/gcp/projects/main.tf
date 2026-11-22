locals {
  # Flatten data projects across declared environments (e.g. data-platform_dev, data-platform_stg, data-platform_prd)
  data_project_matrix = merge([
    for proj_key, proj in var.data_projects : {
      for env in proj.environments : "${proj_key}_${env}" => {
        base_name    = proj_key
        description  = proj.description
        environment  = env
        squad_email  = proj.squad_email
        data_apis    = proj.data_apis
        github_repos = proj.github_repos
        labels       = proj.labels
      }
    }
  ]...)
}

# 1. GCP Multi-Project Data Platform Factory
module "data_projects" {
  source   = "../../_modules/data_project_factory"
  for_each = local.data_project_matrix

  project_base_name = each.value.base_name
  environment       = each.value.environment
  folder_id         = var.folder_id
  billing_account   = var.billing_account
  squad_email       = each.value.squad_email
  data_apis         = each.value.data_apis
  labels            = each.value.labels
  default_region    = var.default_region
}

# 2. Keyless Workload Identity Federation: Connects GitHub Repos to GCP Service Accounts
module "workload_identity" {
  source   = "../../_modules/workload_identity"
  for_each = local.data_project_matrix

  project_id                = module.data_projects[each.key].project_id
  pool_id                   = "wif-data-pool-${each.value.environment}"
  provider_id               = "github-provider"
  github_org                = var.github_org
  authorized_repos          = each.value.github_repos
  target_service_account_id = module.data_projects[each.key].deployer_sa_id
}
