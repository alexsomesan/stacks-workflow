component "cluster" {
  source = "./cluster"

  providers = {
    google = providers.google.main
  }

  inputs = {
    cluster_name       = var.cluster_name
    kubernetes_version = var.kubernetes_version
    region             = var.region
  }
}

component "kube" {
  source = "./kube"

  providers = {
    kubernetes = providers.kubernetes.main
  }
}
