# # https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_secret_backend
resource "vault_azure_secret_backend" "azure" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.secret_client_id
  client_secret   = var.secret_client_secret
  environment     = "AzurePublicCloud"

  path = "azure"
}


# https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_secret_backend_role
resource "vault_azure_secret_backend_role" "azure" {
  backend = vault_azure_secret_backend.azure.path
  role    = "hcp-terraform-role"
  ttl     = 600
  max_ttl = 3600

  azure_roles {
    role_name = "Contributor"
    scope     = "/subscriptions/${var.subscription_id}"
  }
}

# https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_secret_backend_role
resource "vault_azure_secret_backend_role" "azure-vm" {
  backend = vault_azure_secret_backend.azure.path
  role    = "spn-role"
  ttl     = 600
  max_ttl = 3600

  azure_roles {
    role_name = "Contributor"
    scope     = "/subscriptions/${var.subscription_id}"
  }
}
