required_providers {
  kubernetes = {
    source  = "hashicorp/kubernetes"
    version = "2.31.0"
  }
  google = {
    source  = "hashicorp/google"
    version = "~> 5.12.0"
  }
}

provider "google" "main" {
  config {
    project = var.gcp_project
    region  = var.region
  }
}

provider "kubernetes" "main" {
  config {
    host                   = component.cluster.cluster_api
    cluster_ca_certificate = component.cluster.cluster_ca
    token                  = component.cluster.token
  }
}
