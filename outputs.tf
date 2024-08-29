output "public_endpoint_url" {
  value = hcp_vault_cluster.hcp-vault-cluster.vault_public_endpoint_url
}

output "private_endpoint_url" {
  value = hcp_vault_cluster.hcp-vault-cluster.vault_private_endpoint_url
}

output "cluster_id" {
  value = hcp_vault_cluster.hcp-vault-cluster.cluster_id
}

output "hvn_id" {
  value = hcp_hvn.hcp-hvn.hvn_id
}

output "bootstrap_token" {
  value     = hcp_vault_cluster_admin_token.bootstrap-token.token
  sensitive = true
}

output "agent_approle_role_id" {
  value = nonsensitive(vault_approle_auth_backend_role.agent.role_id)
}

output "agent_approle_secret_id" {
  value = nonsensitive(vault_approle_auth_backend_role_secret_id.agent_secret_id.secret_id)
}

output "proxy_approle_role_id" {
  value = nonsensitive(vault_approle_auth_backend_role.proxy.role_id)
}

output "proxy_approle_secret_id" {
  value = nonsensitive(vault_approle_auth_backend_role_secret_id.proxy_secret_id.secret_id)
}

output "dynamic_provider_credemntials_env_vars" {
  value = <<EOF
TFC_VAULT_PROVIDER_AUTH=true
TFC_VAULT_ADDR=${hcp_vault_cluster.hcp-vault-cluster.vault_public_endpoint_url}
TFC_VAULT_NAMESPACE=admin
TFC_VAULT_RUN_ROLE=${vault_jwt_auth_backend_role.workspace.role_name}
TFC_VAULT_AUTH_PATH=${vault_jwt_auth_backend.jwt.path}
  EOF
}
