variable "cluster_name" {
  type = string
}

provider "google" "main" {}

component "cluster" {
  source = "./cluster"

  providers = {
    google = providers.google.main
  }
  inputs = {
    cluster_name = var.cluster_name
  }
}