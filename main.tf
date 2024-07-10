// Pin the version
terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.94.1"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.3.0"
    }
  }
}

// Configure the HCP provider
provider "hcp" {}

// Configure the Vault provider
provider "vault" {
  address    = hcp_vault_cluster.hcp-vault-cluster.public_endpoint
  token      = hcp_vault_cluster_admin_token.bootstrap-token.token
  token_name = "hcp-tf-bootstrap-token"
}
