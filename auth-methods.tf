/**
Azure auth method resources
*/
resource "vault_auth_backend" "azure" {
  type = "azure"

  tune {
    listing_visibility = "unauth"
  }
}

resource "vault_azure_auth_backend_config" "azure" {
  backend       = vault_auth_backend.azure.path
  tenant_id     = var.tenant_id
  client_id     = var.auth_client_id
  client_secret = var.auth_client_secret
  resource      = "https://management.azure.com/"

  lifecycle {
    // if we rotate the client secret outside of terraform in line with best practices, we don't want to trigger a change
    ignore_changes = [client_secret]
  }
}

resource "vault_azure_auth_backend_role" "azure" {
  backend       = vault_auth_backend.azure.path
  role          = "azure-role"
  token_ttl     = var.default_token_ttl
  token_max_ttl = var.default_token_max_ttl

  token_policies = [
    "default", "azure-policy"
  ]

  bound_subscription_ids = [
    var.subscription_id
  ]
}

/**
AppRole auth method resources
*/
resource "vault_auth_backend" "approle" {
  type = "approle"

  tune {
    listing_visibility = "unauth"
  }
}

resource "vault_approle_auth_backend_role" "approle" {
  backend            = vault_auth_backend.approle.path
  role_name          = "servicenow-role"
  token_policies     = ["default", "azure-policy"]
  secret_id_num_uses = 0
  token_ttl          = var.default_token_ttl
  token_max_ttl      = var.default_token_max_ttl
}

resource "vault_approle_auth_backend_role_secret_id" "id" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.approle.role_name
}
