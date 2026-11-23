locals {
  members_roles = distinct(flatten([
    for member in var.members : [
      for role in var.roles : {
        member = member
        role   = role
      }
    ]
  ]))
}

resource "google_bigquery_dataset_iam_member" "dataset_iam" {
  for_each = {
    for item in local.members_roles : "${item.member}_${item.role}" => item
  }

  project    = var.project_id
  dataset_id = var.dataset_id
  role       = each.value.role
  member     = each.value.member
}
