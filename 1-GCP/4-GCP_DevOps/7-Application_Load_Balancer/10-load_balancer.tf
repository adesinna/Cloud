# Reserve a static regional IP address for the load balancer.
# This IP address will be assigned to the load balancer and remain constant, helping with DNS mapping.


resource "google_compute_address" "mylb" {
  name   = "${local.name}-mylb-regional-static-ip" # Name for identification
  region = var.region                              # Specify the region for the IP address
}

# Define a health check for the load balancer to monitor backend instance health.
# This check verifies whether instances respond correctly on the specified path and port.


resource "google_compute_region_health_check" "mylb-healthcheck" {
  name                = "${local.name}-mylb-myapp1-health-check" # Name for identification
  check_interval_sec  = 5             # Time in seconds between each health check
  timeout_sec         = 5             # Time to wait for a health check response
  healthy_threshold   = 2             # Number of successful checks before marking as healthy
  unhealthy_threshold = 3             # Number of failed checks before marking as unhealthy

  # Define the HTTP health check details:
  http_health_check {
    request_path = "/index.html"     # Path to check on each instance
    port         = 80                # Port to use for health checks
  }
}

# Configure a regional backend service to manage traffic distribution to backend instances.
# This service defines the load balancing settings and points to the instance group to serve traffic.


resource "google_compute_region_backend_service" "mylb-backend" {
  name                  = "${local.name}-myapp1-backend-service" # Name for identification
  protocol              = "HTTP"                                # Load balancing protocol
  load_balancing_scheme = "EXTERNAL_MANAGED"                    # Type of load balancer
  health_checks         = [google_compute_region_health_check.mylb-healthcheck.self_link] # Health check
  port_name             = "webserver"                           # Named port to use for backend traffic

  # Define the backend configuration:
  backend {
    group            = google_compute_region_instance_group_manager.myapp1-manager.instance_group # Instance group to receive traffic
    capacity_scaler  = 1.0                         # Scaling factor (1.0 means 100% capacity)
    balancing_mode   = "UTILIZATION"               # Balance based on backend utilization
  }
}

# Define a URL map to route incoming requests to the correct backend service.
# It directs traffic to the default backend service if no URL rules are matched.


resource "google_compute_region_url_map" "mylb-url-map" {
  name            = "${local.name}-mylb-url-map"                  # Name for identification
  default_service = google_compute_region_backend_service.mylb-backend.self_link # Default backend service
}

# Set up a target HTTP proxy for the load balancer, linked to the URL map.
# The proxy forwards HTTP requests to backend instances based on the URL map's configuration.

resource "google_compute_region_target_http_proxy" "mylb-http-proxy" {
  name   = "${local.name}-mylb-http-proxy"              # Name for identification
  url_map = google_compute_region_url_map.mylb-url-map.self_link # URL map to forward requests to
}

# Define a forwarding rule to direct traffic to the target HTTP proxy.
# This rule uses the reserved static IP address and listens on port 80.
resource "google_compute_forwarding_rule" "mylb-forward-rule" {
  name        = "${local.name}-mylb-forwarding-rule"               # Name for identification
  target      = google_compute_region_target_http_proxy.mylb-http-proxy.self_link # HTTP proxy as target
  port_range  = "80"                                              # Port range for incoming traffic
  ip_protocol = "TCP"                                             # Protocol to use for forwarding
  ip_address  = google_compute_address.mylb.address               # Reserved static IP address
  load_balancing_scheme = "EXTERNAL_MANAGED"                      # Type of load balancer
  network = google_compute_network.myvpc.id                       # Network the load balancer operates in

  # Ensure the load balancer is deleted before removing the VPC's proxy-only subnet.
  depends_on = [ google_compute_subnetwork.regional_proxy_subnet ]
}
