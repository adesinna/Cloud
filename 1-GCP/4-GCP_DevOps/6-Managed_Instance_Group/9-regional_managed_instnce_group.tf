# Resource: Regional Health Check
resource "google_compute_region_health_check" "myapp-healthcheck" {
  name                = "${local.name}-myapp-healthcheck"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3
  http_health_check {
    request_path = "/index.html" #remove this if no path
    port         = 80
  }
}

//resource "google_compute_region_health_check" "myapp-healthcheck" {
//  name                = "${local.name}-myapp-healthcheck"
//  check_interval_sec  = 5
//  timeout_sec         = 5
//  healthy_threshold   = 2
//  unhealthy_threshold = 3
//  tcp_health_check {
//    port = 80 # if there is nothing installed use this, it will just check if the port is opened
//  }
//}

# Resource: Managed Instance Group
resource "google_compute_region_instance_group_manager" "myapp1-manager" {
  name                       = "${local.name}-myapp1-mig"
  base_instance_name         = "${local.name}-myapp"
  region                     = var.region
  distribution_policy_zones  = data.google_compute_zones.available.names
  # Instance Template
  version {
    instance_template = google_compute_region_instance_template.myapp1-template.id
  }
  # Named Port
  named_port {
    name = "webserver"
    port = 80
  }
  # Autoscaling
  auto_healing_policies {
    health_check      = google_compute_region_health_check.myapp-healthcheck.id
    initial_delay_sec = 300
  }
}

# Resource: MIG Autoscaling
resource "google_compute_region_autoscaler" "myapp-autoscaler" {
  name   = "${local.name}-myapp1-autoscaler"
  target = google_compute_region_instance_group_manager.myapp1-manager.id
  autoscaling_policy {
    max_replicas    = 6
    min_replicas    = 2
    cooldown_period = 60
    cpu_utilization {
      target = 0.9
    }
  }
}

