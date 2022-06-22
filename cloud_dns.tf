/**
 * destoryして再作成した場合、Cloud DNSのNSレコードを再度Google Domainsのネームサーバに登録し直す
 * （ネームサーバの反映にかなり時間を要することがあるので気長に待つ）
 */

resource "google_dns_managed_zone" "dev_root_dns" {
  name      = "butterthon-dev-jp"
  dns_name  = "butterthon-dev.jp."
  dnssec_config {
    state = "on"
  }
}

resource "google_dns_record_set" "dev_dns" {
  name = "dev-app.${google_dns_managed_zone.dev_root_dns.dns_name}"
  type = "A"
  ttl = 300

  managed_zone = google_dns_managed_zone.dev_root_dns.name
  rrdatas = [google_compute_global_address.static_ip_dev_app.address]
}
