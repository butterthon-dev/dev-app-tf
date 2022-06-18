// 必要な権限
// ・Secret Managerのシークレットバージョンのマネージャー
// ・Secret Managerのシークレットバージョン アクセサー
resource "google_secret_manager_secret" "staging_dev_app_debug" {
  project   = var.project_id
  secret_id = "staging-dev-app_DEBUG"
  replication {
    user_managed {
        replicas { location = var.region }
    }
  }
  labels = { label = "staging" }
}
resource "google_secret_manager_secret" "staging_dev_app_django_settings_module" {
  project   = var.project_id
  secret_id = "staging-dev-app_DJANGO_SETTINGS_MODULE"
  replication {
    user_managed {
        replicas { location = var.region }
    }
  }
  labels = { label = "staging" }
}
resource "google_secret_manager_secret" "staging_dev_app_django_secret_key" {
  project   = var.project_id
  secret_id = "staging-dev-app_DJANGO_SECRET_KEY"
  replication {
    user_managed {
        replicas { location = var.region }
    }
  }
  labels = { label = "staging" }
}
resource "google_secret_manager_secret" "staging_dev_app_database_url" {
  project   = var.project_id
  secret_id = "staging-dev-app_DATABASE_URL"
  replication {
    user_managed {
        replicas { location = var.region }
    }
  }
  labels = { label = "staging" }
}
resource "google_secret_manager_secret" "staging_dev_app_django_allowed_hosts" {
  project   = var.project_id
  secret_id = "staging-dev-app_DJANGO_ALLOWED_HOSTS"
  replication {
    user_managed {
        replicas { location = var.region }
    }
  }
  labels = { label = "staging" }
}

resource "google_secret_manager_secret_version" "v_staging_dev_app_debug" {
  secret        = google_secret_manager_secret.staging_dev_app_debug.id
  secret_data   = "False"
}
resource "google_secret_manager_secret_version" "v_staging_dev_app_django_settings_module" {
  secret        = google_secret_manager_secret.staging_dev_app_django_settings_module.id
  secret_data   = "config.settings.prd"
}
resource "google_secret_manager_secret_version" "v_staging_dev_app_django_secret_key" {
  secret        = google_secret_manager_secret.staging_dev_app_django_secret_key.id
  secret_data   = "django-insecure-zgxe_knf8as%_$o%jq$4yw@i5p6f0d8p74&a!avsuvfctu+)(c"
}
resource "google_secret_manager_secret_version" "v_staging_dev_app_database_url" {
  secret        = google_secret_manager_secret.staging_dev_app_database_url.id
  secret_data   = "mysql://${google_sql_user.sql_user_dev_app.name}:${var.sql_user_password}@127.0.0.1:3306/${google_sql_database.db_dev_app.name}?charset=utf8mb4"
}
resource "google_secret_manager_secret_version" "v_staging_dev_app_django_allowed_hosts" {
  secret        = google_secret_manager_secret.staging_dev_app_django_allowed_hosts.id
  secret_data   = "*"
}
