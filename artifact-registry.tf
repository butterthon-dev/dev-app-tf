resource "google_artifact_registry_repository" "dev_app_img_repository" {
  provider      = google-beta
  location      = var.region
  repository_id = "dev-app-img-repository"
  format        = "DOCKER"
}
