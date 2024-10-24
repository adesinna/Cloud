//# Get each list item separately
//output "vm_name_0" {
//  description = "VM Name"
//  value = google_compute_instance.myapp[0].name
//}
//
//# Get each list item separately
//output "vm_name_1" {
//  description = "VM Name"
//  value = google_compute_instance.myapp[1].name
//}
//
//# Output - For Loop with List
//output "for_output_list" {
//  description = "For Loop with List"
//  value = [
//    for instance in google_compute_instance.myapp:
//      instance.name
//  ]
//}
//
//# Output - For Loop with Map
//output "for_output_map1" {
//  description = "For Loop with Map"
//  value = {
//    for instance in google_compute_instance.myapp:
//      instance.name => instance.instance_id
//    }
//}
//
//# Output - For Loop with Map Advanced
//output "for_output_map2" {
//  description = "For Loop with Map - Advanced"
//  value = {
//    for c, instance in google_compute_instance.myapp:
//      c => instance.name
//    }
//}
//# VM External IPs
//output "vm_external_ips" {
//  description = "For Loop with Map - Advanced"
//  value = {
//    for c, instance in google_compute_instance.myapp:
//      c => instance.network_interface.0.access_config.0.nat_ip
//    }
//}
//
//# Output - For Loop with Map Advanced
//output "for_output_map3" {
//  description = "For Loop with Map - Advanced (Instance Name and Instance ID)"
//  value = {
//    for c, instance in google_compute_instance.myapp:
//      instance.name => instance.instance_id
//    }
//}
//
//# Output Legacy Splat Operator (Legacy) - Returns the List
//output "legacy_splat_instance" {
//  description = "Legacy Splat Operator"
//  value = google_compute_instance.myapp.*.name
//}
//
//# Output Latest Generalized Splat Operator - Returns the List
//output "latest_splat_instance" {
//  description = "Generalized latest Splat Operator"
//  value = google_compute_instance.myapp[*].name
//}

#
# FOR EACH OUTPUT
# Terraform Output Values
# Output - For with list
output "for_output_list1" {
  description = "For Loop with List"
  value = [
  for instance in google_compute_instance.myapp:
    instance.name
  ]
}

# Output - For Loop with Map
output "for_output_map1" {
  description = "For Loop with Map1"
  value = {
  for instance in google_compute_instance.myapp:
    instance.name => instance.instance_id
  }
}

# Output - VM External IPs
output "vm_external_ips" {
  description = "VM Instance Names -> VM External IPs"
  value = {
  for instance in google_compute_instance.myapp:
    instance.name => instance.network_interface.0.access_config.0.nat_ip}
}