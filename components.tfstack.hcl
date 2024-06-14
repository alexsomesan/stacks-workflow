variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "region" {
  type = string
}

component "cluster" {
  source = "./cluster"

  providers = {
    google = providers.google.main
  }

  inputs = {
    cluster_name = var.cluster_name
    kubernetes_version  = var.kubernetes_version
    region = var.region
  }
}

component "kube" {
  source = "./kube"

  providers = {
    google = providers.google.main
    kubernetes = providers.kubernetes.main
  }

  inputs = {
    cluster_api = component.cluster.cluster_api
    cluster_ca  = component.cluster.cluster_ca
    token = component.cluster.token
  }
}
