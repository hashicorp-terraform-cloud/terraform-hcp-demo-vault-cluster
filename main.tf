# Create the HashiCorp Virtual Network
resource "hcp_hvn" "hcp-hvn" {
  hvn_id         = "hvn-${var.cloud_provider}-${var.cloud_region}"
  cloud_provider = var.cloud_provider
  region         = var.cloud_region
  cidr_block     = var.hvn_cidr_block
}

# Create the HashiCorp Vault Cluster
resource "hcp_vault_cluster" "hcp-vault-cluster" {
  cluster_id      = var.cluster_id
  hvn_id          = hcp_hvn.hcp-hvn.hvn_id
  tier            = var.cluster_tier
  public_endpoint = var.expose_public_endpoint

  dynamic "ip_allowlist" {
    for_each = var.cluster_ip_allowlist
    content {
      address     = ip_allowlist.value.address
      description = ip_allowlist.value.description
    }
  }
}
# Create the HashiCorp Vault Cluster Admin Token for initial configuration
resource "hcp_vault_cluster_admin_token" "bootstrap-token" {
  cluster_id = hcp_vault_cluster.hcp-vault-cluster.cluster_id
}
