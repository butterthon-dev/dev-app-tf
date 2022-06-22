# Workload Identity Pool管理者
resource "google_iam_workload_identity_pool" "workload_identity_pool" {
  provider = google-beta
  workload_identity_pool_id = "workload-identity-pool"
}

resource "google_iam_workload_identity_pool_provider" "dev_app_provider" {
  provider                              = google-beta
  workload_identity_pool_id             = google_iam_workload_identity_pool.workload_identity_pool.workload_identity_pool_id
  workload_identity_pool_provider_id    = "dev-app-provider"
  attribute_mapping                     = {
    "google.subject"        = "assertion.sub"
    "attribute.actor"       = "assertion.actor"
    "attribute.repository"  = "assertion.repository"
    "attribute.aud"         = "assertion.aud"
  }
#   attribute_condition = "'butterthon-dev/dev-app' == assertion.repository"

  oidc {
    # issuer_uri = "https://github.com/butterthon-dev"
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_member" "sa_github_actions" {
  service_account_id    = google_service_account.gke_sa_github_actions.id
  role                  = "roles/iam.workloadIdentityUser"
  member                = "principalSet://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.workload_identity_pool.workload_identity_pool_id}/*"
}
