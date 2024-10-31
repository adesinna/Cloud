# Resource: VPC
resource "google_compute_network" "myvpc" {
  name = "${local.name}-vpc"
  auto_create_subnetworks = false
}

# Resource: Subnet
resource "google_compute_subnetwork" "mysubnet" {
  name = "${var.region}-subnet"
  region = var.region
  ip_cidr_range = "10.128.1.0/24"
  network = google_compute_network.myvpc.id
}