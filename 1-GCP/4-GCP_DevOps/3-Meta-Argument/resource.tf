#vpc
resource "google_compute_network" "vpc_network" {
  project                 = "myprject"
  name                    = "vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}


resource "google_compute_subnetwork" "test-subnetwork1" {

  provider = google.us-central1 # using the alias to call it
  name          = "test-subnetwork1"
  ip_cidr_range = "10.2.0.0/16"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "test-subnetwork2" {

  provider = google.europe-west1 # using the alias to call it
  name          = "test-subnetwork2"
  ip_cidr_range = "10.2.0.0/16"
  network       = google_compute_network.vpc_network.id
}

