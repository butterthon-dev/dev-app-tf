// Google DomainsとCloud DNS
// === Cloud DNSでの操作 ===
// 1. レコードセットのNSレコードを選択
// 2. データに表示されているネームサーバを全てコピー（2022/6/3時点では4レコードあった）
//
// === Google Domainsでの操作 ===
// 1. 左のサイドバーから「DNS」を選択
// 2. 「カスタムネームサーバ」タブを選択
// 3. 「ネームサーバの管理」リンク押下
// 4. 上記3. でコピーしたネームサーバを全て追加
// 5. 「保存」ボタン押下
// 6. 「これらの設定に切り替える」でカスタムネームサーバの使用に切り替える
// 以上
resource "google_compute_network" "network_dev_app" {
  name = "network-dev-app"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_dev_app" {
  name = "subnet-dev-app"
  ip_cidr_range = "10.0.1.0/24"
  region = var.region
  network = google_compute_network.network_dev_app.id
}

// 予約IPアドレス
resource "google_compute_global_address" "static_ip_dev_app" {
  name = "static-ip-dev-app"
}
