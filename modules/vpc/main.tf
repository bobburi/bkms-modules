resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnets" {
  for_each          = { for subnet in var.subnets : subnet.name => subnet }
  name              = each.value.name
  ip_cidr_range     = each.value.ip_cidr_range
  region            = each.value.region
  network           = google_compute_network.vpc.self_link
  private_ip_google_access = each.value.private_access
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
  
  dynamic "secondary_ip_range" {
    for_each = lookup(var.secondary_ranges, each.value.name, {})
    content {
      range_name    = secondary_ip_range.value.name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
}
