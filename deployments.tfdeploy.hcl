deployment "demo" {
    variables = {
        cluster_name = "demo"
        kubernetes_version = "1.29"
        region = "europe-central2"
        gcp_project = "hc-terraform-k8s-testing"
    }
}