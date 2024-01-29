# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "kubernetes_version" {
  default = "1.27"
}

variable "workers_count" {
  default = "3"
}

variable "cluster_name" {
  type = string
}

variable "idp_enabled" {
  type    = bool
  default = false
}

# This is used to set local variable google_zone.
# This can be replaced with a statically-configured zone, if preferred.
data "google_compute_zones" "available" {
  provider = google-beta
}

locals {
  google_zone = data.google_compute_zones.available.names[0]
}

data "google_container_engine_versions" "supported" {
  provider = google-beta

  location       = local.google_zone
  version_prefix = var.kubernetes_version
}

resource "google_container_cluster" "default" {
  provider = google-beta

  name               = var.cluster_name
  location           = local.google_zone
  initial_node_count = var.workers_count
  min_master_version = data.google_container_engine_versions.supported.latest_master_version
  # node version must match master version
  # https://www.terraform.io/docs/providers/google/r/container_cluster.html#node_version
  node_version = data.google_container_engine_versions.supported.latest_master_version

  release_channel {
    channel = "RAPID"
  }

  node_locations = [
    data.google_compute_zones.available.names[1],
  ]

  node_config {
    machine_type = "n1-standard-4"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  identity_service_config {
    enabled = var.idp_enabled
  }

  deletion_protection = false
}


# Outputs
output "node_version" {
  value = google_container_cluster.default.node_version
}

output "google_zone" {
  value = local.google_zone
}
