provider "google" {
  project = "myproject"
  region = "us-central1"
  alias = "us-central1"
}

provider "google" {
  project = "myproject2"
  region = "europe-west1"
  alias = "europe-west1"
}

# we define two provider that can use two different regions


