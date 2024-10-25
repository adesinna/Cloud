# Input Variables
# GCP Project
variable "project" {
  description = "Project in which GCP Resources to be created"
  type = string
  default = "devops-437421"
}

# GCP Region
variable "region" {
  description = "Region in which GCP Resources to be created"
  type = string
  default = "us-central1"
}

# GCP Compute Engine Machine Type
variable "machine_type" {
  description = "Compute Engine Machine Type"
  type = string
  default = "e2-small"
}


# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "test"
}

# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "geotech"
}