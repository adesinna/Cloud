#vpc
resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = "vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

# subnet

resource "google_compute_subnetwork" "test-subnetwork" {
  depends_on = [google_compute_network.vpc_network]

  name          = "test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = var.GCP_region
  network       = google_compute_network.vpc_network.id
}

#firewall

resource "google_compute_firewall" "instance-rules" {
  depends_on = [google_compute_subnetwork.test-subnetwork]

  project     = var.project
  name        = "instance-rules"
  network     = google_compute_network.vpc_network.id
  direction     = "INGRESS"
  priority = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["webserver"] # the tags of the instances
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["80", "22"]
  }

}

# Resource Block: Create a single Compute Engine instance
resource "google_compute_instance" "myapp1" {
  name         = "myapp1"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  tags        = ["webserver"]


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  # Install Webserver
  metadata_startup_script = file("${path.module}/script.sh")

  network_interface {
    subnetwork = google_compute_subnetwork.test-subnetwork.id
    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}


output "instance_public_ip" {
  value = google_compute_instance.myapp1.network_interface[0].access_config[0].nat_ip
  description = "The public IP address of the instance"
}
