# Створення віртуальної приватної мережі (VPC)
resource "google_compute_network" "vpc_network" {
  name                    = "lab3-vpc-var13"
  auto_create_subnetworks = false
}

# Створення підмережі A
resource "google_compute_subnetwork" "subnet_a" {
  name          = "subnet-a-var13"
  ip_cidr_range = var.subnet_a_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

# Створення підмережі B
resource "google_compute_subnetwork" "subnet_b" {
  name          = "subnet-b-var13"
  ip_cidr_range = var.subnet_b_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

# Налаштування Firewall
resource "google_compute_firewall" "allow_ssh_web" {
  name    = "allow-ssh-web-var13"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["22", var.web_port] # Відкриваємо 22 (SSH) та 8000 (Web)
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}

# Розгортання віртуальної машини
resource "google_compute_instance" "web_server" {
  name         = "apache-server-var13"
  machine_type = "e2-micro"
  zone         = "${var.region}-a"
  tags         = ["web-server", "lab3", "maselko"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64" # Ubuntu 24.04 LTS
      size  = 20
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet_a.id
    access_config {
      # Цей блок видає зовнішню IP-адресу
    }
  }

  # Підключення скрипта ініціалізації
  metadata_startup_script = file("${path.module}/bootstrap.sh")
}