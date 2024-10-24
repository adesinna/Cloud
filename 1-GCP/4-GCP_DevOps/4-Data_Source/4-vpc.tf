# Resource: VPC
resource "google_compute_network" "myvpc" {
  name = "myvpc"
  auto_create_subnetworks = false
}

# Resource: Subnet
resource "google_compute_subnetwork" "mysubnet" {
  name = "${var.region}-subnet"
  region = var.region
  ip_cidr_range = "10.128.0.0/16"
  network = google_compute_network.myvpc.id
}