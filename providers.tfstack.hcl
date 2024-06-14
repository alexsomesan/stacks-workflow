required_providers {
  kubernetes = {
    source = "hashicorp/kubernetes"
  }
  google = {
    source = "hashicorp/google"
  }
}

provider "google" "main" {}

provider "kubernetes" "main" {}
