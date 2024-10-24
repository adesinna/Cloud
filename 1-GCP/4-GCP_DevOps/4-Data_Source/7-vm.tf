# Resource Block: Create a Compute Engine instance
resource "google_compute_instance" "myapp" {

//  count = 2  either use count or for each
//    name         = "myapp-vm-${count.index}"
  for_each = toset(data.google_compute_zones.available.names) # tuples
  name         = "myapp-vm-${each.key}" # pick each things in the tuples
  machine_type = var.machine_type
//  zone         = data.google_compute_zones.available.names[count.index] #this is for "count"
  zone         = each.key #this is for "for each"

  # the tags below will take each tags in the security group and put it in a list
  tags        = [tolist(google_compute_firewall.ssh-rule.target_tags)[0], tolist(google_compute_firewall.http-rule.target_tags)[0]]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  # Install Webserver
  metadata_startup_script = file("${path.module}/script.sh")

  network_interface {
    subnetwork = google_compute_subnetwork.mysubnet.id
    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}