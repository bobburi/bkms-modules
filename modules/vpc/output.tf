output "vpc_self_link" {
  description = "The self-link of the created VPC"
  value       = google_compute_network.vpc.self_link
}

output "subnet_self_links" {
  description = "The self-links of the created subnets"
  value       = { for s in google_compute_subnetwork.subnets : s.name => s.self_link }
}
