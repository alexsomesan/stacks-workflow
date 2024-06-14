output "cluster_api" {
  value = "https://${google_container_cluster.default.endpoint}"
}

output "cluster_ca" {
  value = base64decode(google_container_cluster.default.master_auth[0].cluster_ca_certificate)
}

output "token" {
  value = data.google_client_config.provider.access_token
}

output "node_version" {
  value = google_container_cluster.default.node_version
}

output "google_zone" {
  value = local.google_zone
}
