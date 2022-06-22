// Github Actions用のIAMサービスアカウント
// 
// ・Service Usage ユーザー
// ・Cloud Build サービスアカウント
// の両方を付与しないと「ERROR: (gcloud.builds.submit) The user is forbidden from accessing the bucket [cloud-learn-dev_cloudbuild]. Please check your organization's policy or if the user has the "serviceusage.services.use" permission」になる
//
// ・roles/viewerを指定しないと
// 「ERROR: (gcloud.builds.submit) 」となり、イメージビルドもARへのpushも完了しているのに、なぜかGithubActionsのjobがエラーになる
// ※ ログのバケットを指定しておけばこの権限は付与しなくてもいいかも
resource "google_service_account" "gke_sa_github_actions" {
  account_id    = "gke-sa-github-actions"
  display_name  = "gke-sa-github-actions"
}

// Artifact Registry 読み取り
resource "google_project_iam_member" "sa_artifact_registry_reader_github_actions" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.gke_sa_github_actions.email}"
}
// Service Usage ユーザー
resource "google_project_iam_member" "sa_service_usage_consumer_github_actions" {
  project = var.project_id
  role    = "roles/serviceusage.serviceUsageConsumer"
  member  = "serviceAccount:${google_service_account.gke_sa_github_actions.email}"
}
// Cloud Build 閲覧者
resource "google_project_iam_member" "sa_cloud_build_viewer_github_actions" {
  project = var.project_id
  role    = "roles/cloudbuild.builds.viewer"
  member  = "serviceAccount:${google_service_account.gke_sa_github_actions.email}"
}
// ストレージ オブジェクト 管理者
resource "google_project_iam_member" "sa_storage_admin_github_actions" {
  project = var.project_id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.gke_sa_github_actions.email}"
}
// Cloud Build サービスアカウント
resource "google_project_iam_member" "sa_cloud_build_builder_github_actions" {
  project = var.project_id
  role    = "roles/cloudbuild.builds.builder"
  member  = "serviceAccount:${google_service_account.gke_sa_github_actions.email}"
}
// 閲覧者
resource "google_project_iam_member" "sa_viewer_github_actions" {
  project = var.project_id
  role    = "roles/viewer"
  member  = "serviceAccount:${google_service_account.gke_sa_github_actions.email}"
}
