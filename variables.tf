variable "credentials_file_path" {
    type        = string
    default     = "./tf_service_account.json"
    description = "サービスアカウントJSONファイルのパス"
}

variable "project_id" {
    type        = string
    description = "プロジェクトID"
}

variable "project_number" {
    type        = string
    description = "プロジェクトNo."
}

variable "region" {
    type    = string
    default = "asia-northeast1"
}

variable "zone" {
    type    = string
    default = "asia-northeast1-a"
}

variable "sql_user_password" {
  type      = string
  sensitive = true
}
