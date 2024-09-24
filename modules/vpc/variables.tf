variable "project_id" {
  type        = string
  description = "The project ID to deploy the VPC."
}

variable "network_name" {
  type        = string
  description = "The name of the VPC."
}

variable "subnets" {
  description = "A list of subnets to be created."
  type = list(object({
    name           = string
    ip_cidr_range  = string
    region         = string
    private_access = bool
    flow_logs      = bool
  }))
}

variable "secondary_ranges" {
  description = "A list of secondary IP ranges for subnets."
  type = map(map(string)) # Allows for multiple secondary ranges
  default = {}
}
