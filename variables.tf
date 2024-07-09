variable "hvn_cidr_block" {
  description = "the cidr block for the hashicorp virtual network. should not overlap with any existing networks for peering purposes."
  type        = string
}

variable "cluster_id" {
  description = "the id of the cluster to create. must be unique within the account."
  type        = string
}

variable "cluster_tier" {
  description = "value of the tier for the cluster. see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#tier for more information."
  type        = string
  default     = "standard_small"
}

variable "cloud_provider" {
  description = "value of the cloud provider for the cluster. see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#cloud_provider for more information."
  type        = string
  default     = "azure"
}

variable "cluster_ip_allowlist" {
  description = "list of objects containing address and description for the ip allowlist"
  type = list(object({
    address     = string
    description = string
  }))
  default = [{
    address     = "0.0.0.0/0",
    description = "allow all traffic"
    }
  ]
}

variable "cloud_region" {
  description = "value of the cloud region for the cluster. see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#region for more information."
  type        = string
  default     = "westeurope"
}

variable "expose_public_endpoint" {
  description = "value of the public endpoint for the cluster. see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#public_endpoint for more information."
  type        = bool
  default     = true
}
