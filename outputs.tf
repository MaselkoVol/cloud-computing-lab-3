output "instance_name" {
  description = "Ім'я створеної віртуальної машини"
  value       = google_compute_instance.web_server.name
}

output "instance_public_ip" {
  description = "Зовнішня IP-адреса ВМ"
  value       = google_compute_instance.web_server.network_interface[0].access_config[0].nat_ip
}

output "website_url" {
  description = "Повна адреса (URL) налаштованого сервісу"
  value       = "http://${google_compute_instance.web_server.network_interface[0].access_config[0].nat_ip}:${var.web_port}"
}