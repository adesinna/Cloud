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
output "mylb_static_ip_address" {
  description = "The static IP address of the load balancer."
  value       = google_compute_address.mylb.address
}

output "mylb_backend_service_self_link" {
  description = "The self link of the backend service."
  value       = google_compute_region_backend_service.mylb-backend.self_link
}

output "mylb_url_map_self_link" {
  description = "The self link of the URL map."
  value       = google_compute_region_url_map.mylb-url-map.self_link
}

output "mylb_target_http_proxy_self_link" {
  description = "The self link of the target HTTP proxy."
  value       = google_compute_region_target_http_proxy.mylb-http-proxy.self_link
}

output "mylb_forwarding_rule_ip_address" {
  description = "The IP address of the forwarding rule."
  value       = google_compute_forwarding_rule.mylb-forward-rule.ip_address
}
