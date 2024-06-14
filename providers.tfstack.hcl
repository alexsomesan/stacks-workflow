required_providers {
  kubernetes = {
    source  = "hashicorp/kubernetes"
    version = "2.31.0"
  }
  google = {
    source  = "hashicorp/google-beta"
    version = "4.85.0"
  }
}

provider "google" "main" {
  project = var.gcp_project
  region  = var.region
}

provider "kubernetes" "main" {
  host                   = component.cluster.cluster_api
  cluster_ca_certificate = component.cluster.cluster_ca
  token                  = component.cluster.token
}
