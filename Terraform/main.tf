#Mise en place du réseau
resource "google_compute_network" "vpc_network" {
  name                    = "my-network"
  auto_create_subnetworks = false
}
#Mise en place du sous réseau
resource "google_compute_subnetwork" "default" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-west1"
  network       = google_compute_network.vpc_network.id
}
#Mise en place du Parefeu
resource "google_compute_firewall" "http_https" {
  name = "allow-http-https-ssh"
  allow {
    ports    = ["80","443","22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "mysql" {
  name = "allow-mysql"
  allow {
    ports    = ["3306"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["10.0.1.0/24"]
}
#Mise en place de 2 VM
resource "google_compute_instance" "wordpress" {
  name         = "wordpress-vm"
  machine_type = "f1-micro"
  zone         = "us-west1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.default.id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}
resource "google_compute_instance" "database" {
  name         = "database-vm"
  machine_type = "f1-micro"
  zone         = "us-west1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.default.id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}
#Mise en place du compte de service 
resource "google_service_account" "service_account" {
  account_id   = "terraform"
  display_name = "terraform"
}
resource "google_service_account_key" "service_account" {
  service_account_id = google_service_account.service_account.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}
resource "local_file" "service_account" {
    content  = base64decode(google_service_account_key.service_account.private_key)
    filename = "../Ansible/service_account.json"
}
resource "google_project_iam_binding" "project" {
  project = "cursusm2i-soukaina"
  role    = "roles/viewer"

  members = [
    "serviceAccount:${google_service_account.service_account.email}",
  ]
}