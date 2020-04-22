resource "google_compute_instance" "raddit" {
  name         = "raddit-instance"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"

  # Параметры загрузочного диска
  boot_disk {
    initialize_params {
      image = "raddit-base" // Используем image который мы собирали через Packer
    }
  }

  # Какую сеть мы будем использовать на instance'е
  network_interface {
    network = "default"
    access_config {} // используем эфимерный (динамеческий) ipv4 внешний адрес
  }

  metadata = {
    enable-oslogin = "TRUE"
    startup-script = file("../deploy.sh")
  }
}

resource "google_compute_firewall" "raddit" {
  name    = "allow-raddit-tcp-9292"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
}

provider "google" {
  project = "infrastructure-as-code" # Замени здесь на свой project_id
  region  = "europe-west1"
}

output "raddit_public_ip" { # Это способ, вывести любое значение. Здесь мы через точку обращаемся сначала к ресурсу google_compute_instance , потом конкретно к нашему raddit, к ему network_interface, и просим вывести nat_ip.
  value = google_compute_instance.raddit.network_interface.0.access_config.0.nat_ip
}
