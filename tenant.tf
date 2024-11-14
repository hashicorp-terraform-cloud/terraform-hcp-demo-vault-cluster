resource "vault_namespace" "tenant" {
  path = "tenant"
}

# # https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_secret_backend
resource "vault_azure_secret_backend" "azure" {
  namespace       = vault_namespace.tenant.path
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.secret_client_id
  client_secret   = var.secret_client_secret
  environment     = "AzurePublicCloud"

  path = "azure"

}

# https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_secret_backend_role
resource "vault_azure_secret_backend_role" "terraform" {
  namespace = vault_namespace.tenant.path
  backend   = vault_azure_secret_backend.azure.path
  role      = "hcp-terraform-role"
  ttl       = 600
  max_ttl   = 3600

  azure_roles {
    role_name = "Contributor"
    scope     = "/subscriptions/${var.subscription_id}"
  }
}

# https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_secret_backend_role
resource "vault_azure_secret_backend_role" "spn" {
  namespace = vault_namespace.tenant.path
  backend   = vault_azure_secret_backend.azure.path
  role      = "spn-role"
  ttl       = 600
  max_ttl   = 3600

  azure_roles {
    role_name = "Contributor"
    scope     = "/subscriptions/${var.subscription_id}"
  }
}


resource "vault_mount" "kvv2" {
  namespace   = vault_namespace.tenant.path
  path        = "kvv2"
  type        = "kv"
  options     = { version = "2" }
  description = "Key Value secrets store for consumer data"
}
