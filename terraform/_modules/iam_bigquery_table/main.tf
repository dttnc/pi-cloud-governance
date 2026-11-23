locals {
  table_member_roles = distinct(flatten([
    for member in var.members : [
      for role in var.roles : [
        for table in var.tables : {
          member   = member
          role     = role
          table_id = table
        }
      ]
    ]
  ]))
}

resource "google_bigquery_table_iam_member" "table_iam" {
  for_each = {
    for item in local.table_member_roles : "${item.table_id}_${item.member}_${item.role}" => item
  }

  project    = var.project_id
  dataset_id = var.dataset_id
  table_id   = each.value.table_id
  role       = each.value.role
  member     = each.value.member
}
