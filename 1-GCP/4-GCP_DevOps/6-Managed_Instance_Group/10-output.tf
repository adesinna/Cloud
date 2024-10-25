# Terraform Output Values
output "myapp1_mig_id" {
  value = google_compute_region_instance_group_manager.myapp1-manager.id
}

output "myapp1_mig_instance_group" {
  value = google_compute_region_instance_group_manager.myapp1-manager.instance_group
}

output "myapp1_mig_self_link" {
  value = google_compute_region_instance_group_manager.myapp1-manager.self_link
}

output "myapp1_mig_status" {
  value = google_compute_region_instance_group_manager.myapp1-manager.status
}