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
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }
}

// Configure the HCP provider
provider "hcp" {}

// Configure the Random provider
provider "random" {}

// Configure the Vault provider
provider "vault" {
  address    = hcp_vault_cluster.hcp-vault-cluster.vault_public_endpoint_url
  token      = hcp_vault_cluster_admin_token.bootstrap-token.token
  token_name = "hcp-tf-bootstrap-token"
}

data "vault_namespace" "current" {}
