// Pin the version
terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.94.1"
    }
  }
}

// Configure the provider
provider "hcp" {}
