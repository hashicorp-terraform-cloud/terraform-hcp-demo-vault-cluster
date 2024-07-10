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

output "approle_role_id" {
  value = nonsensitive(vault_approle_auth_backend_role.approle.role_id)
}

output "approle_secret_id" {
  value = nonsensitive(vault_approle_auth_backend_role_secret_id.id.secret_id)
}
