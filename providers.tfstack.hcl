required_providers {
  kubernetes = {
    source  = "hashicorp/kubernetes"
    version = "~> 2.31.0"
  }
  google-beta = {
    source  = "hashicorp/google-beta"
    version = "~> 5.37.0"
  }
}

provider "google-beta" "main" {
  config {
    project = var.gcp_project
    region  = var.gcp_region
    credentials = jsonencode(
      {
        "type": "external_account",
        "audience": var.gcp_audience,
        "subject_token_type": "urn:ietf:params:oauth:token-type:jwt",
        "token_url": "https://sts.googleapis.com/v1/token",
        "credential_source": {
          "file": var.identity_token_file
        },
        "service_account_impersonation_url": format("https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/%s:generateAccessToken", var.gcp_service_account_email)
      }
    )
  }
}

provider "kubernetes" "main" {
  config {
    host                   = component.cluster.cluster_api
    cluster_ca_certificate = component.cluster.cluster_ca
    token                  = "foobar"
  }
}
