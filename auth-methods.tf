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
  role_name          = "agent-role"
  token_policies     = ["default", "azure-policy", "agent-management-policy"]
  secret_id_num_uses = 0
  secret_id_ttl      = 600
  token_ttl          = 300
  token_max_ttl      = 600
}

resource "vault_approle_auth_backend_role" "approle" {
  backend            = vault_auth_backend.approle.path
  role_name          = "proxy-role"
  token_policies     = ["default", "azure-policy", "agent-management-policy"]
  secret_id_num_uses = 0
  secret_id_ttl      = 600
  token_ttl          = 300
  token_max_ttl      = 600
}

resource "vault_approle_auth_backend_role_secret_id" "id" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.approle.role_name
}

/**
JWT auth method for HCP Terraform
*/
resource "vault_jwt_auth_backend" "jwt" {
  description        = "JWT Auth Backend for Dynamic Provider Credentials"
  path               = "jwt"
  oidc_discovery_url = "https://app.terraform.io"
  bound_issuer       = "https://app.terraform.io"
}

resource "vault_jwt_auth_backend_role" "workspace" {
  backend        = vault_jwt_auth_backend.jwt.path
  role_name      = "vault-jwt-auth-workspace"
  token_policies = ["hcp-tf-policy"]

  bound_audiences   = ["vault.workload.identity"]
  bound_claims_type = "glob"
  bound_claims = {
    sub = "organization:${var.hcptf_organisation_id}:project:*:workspace:*:run_phase:*"
  }
  user_claim    = "terraform_project_name"
  role_type     = "jwt"
  token_ttl     = 300
  token_max_ttl = 3600
}
