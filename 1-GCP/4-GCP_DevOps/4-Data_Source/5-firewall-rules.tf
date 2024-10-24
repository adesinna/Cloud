# Firewall Rule: SSH
resource "google_compute_firewall" "ssh-rule" {
  name = "ssh-rule"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.myvpc.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-tag"]  # the servers that will have this tag attached
}

# Firewall Rule: HTTP Port 80
resource "google_compute_firewall" "http-rule" {
  name = "http-rule"
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.myvpc.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["webserver-tag"] # the servers that will have this tag attached
}