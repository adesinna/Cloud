# Input Variables that would be generic
# AWS Region
variable "GCP_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-central1"
}

# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "busyqa"
}

# Cluster name Variable
variable "project" {
  description = "Name of the project"
  type = string
  default = "devops-437421" # with id
}


