// GKE用のサービスアカウント
resource "google_service_account" "gke_sa_dev_app" {
  account_id    = "gke-sa-dev-app"
  display_name  = "gke-sa-dev-app"
}

# GKE用のサービスアカウントにロール付与
# ・Cloud SQL クライアント
# ・Secret Manager のシークレット アクセサー
resource "google_project_iam_member" "sa_sql_client_dev_app" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.gke_sa_dev_app.email}"
}
resource "google_project_iam_member" "sa_secret_accessor_dev_app" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.gke_sa_dev_app.email}"
}

/**
 * クラスターの作成に10分くらい時間が掛かる
 * ノードプールの作成に3分くらい時間が掛かる
 */
resource "google_container_cluster" "cluster_dev_app" {
  name      = "cluster-dev-app"
  location  = var.region

  remove_default_node_pool  = true
  initial_node_count        = 1
  node_config {
    service_account = google_service_account.gke_sa_dev_app.email // GKEサービスアカウント
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  timeouts {
    create = "30m"
    update = "40m"
  }

  # GKEサービスアカウントをIAMのサービスアカウントとして機能させる
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "node_pool_dev_app" {
  name          = "node-pool-dev-app"
  location      = var.region
  cluster       = google_container_cluster.cluster_dev_app.name
  node_count    = 1
  autoscaling {
    min_node_count = 0
    max_node_count = 1
  }

  node_config {
    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }
}
