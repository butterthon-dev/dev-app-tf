// Cloud SQL Admin APIを有効にしておく（5分くらい待った方がいい）
// そもそもSQLインスタンスの生成に時間が掛かるので、applyも時間かかる（15分前後）
resource "google_sql_database" "db_dev_app" {
  name      = "db-dev-app"
  instance  = google_sql_database_instance.db_instance_dev_app.id
}

resource "google_sql_database_instance" "db_instance_dev_app" {
  name              = "db-instance-dev-app"
  region            = var.region
  database_version  = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"
  }

  deletion_protection = false
}

resource "google_sql_user" "sql_user_dev_app" {
  name      = "butterthon"
  instance  = google_sql_database_instance.db_instance_dev_app.name
  password  = var.sql_user_password
}
