/**
CIDR Block Recommendations

If the CIDR block values for your HVN and VNets overlap, then you will not be able to establish a connection. Ensure that any VNets you plan to connect do not have overlapping values.
The default HVN CIDR block value does not overlap with the default CIDR block value for Azure VNets (172.31.0.0/16). However, if you are planning to use this HVN in production, we recommend adding a custom value instead of using the default.
The CIDR block value must be a private IPv4 CIDR block within the RFC1918 address space (10.*.*.*, 192.168.*.*, 172.[16-31].*.*).
The CIDR block value must be the first IP address of the desired CIDR block.
The CIDR block value must end between /16 and /25.
**/
variable "hvn_cidr_block" {
  description = "The CIDR block for the HashiCorp Virtual Network. Should not overlap with any existing networks for peering purposes."
  type        = string

  validation {
    condition     = can(cidrsubnet(var.hvn_cidr_block, 0, 0))
    error_message = "The CIDR block value must be a valid subnet."
  }

  validation {
    condition     = cidrsubnet(var.hvn_cidr_block, 0, 0) >= 16 && cidrsubnet(var.hvn_cidr_block, 0, 0) <= 25
    error_message = "The CIDR block value must end between /16 and /25."
  }

  validation {
    condition     = cidrhost(var.hvn_cidr_block, 0) == var.hvn_cidr_block
    error_message = "The CIDR block value must be the first IP address of the desired CIDR block."
  }

  validation {
    condition = (
      cidrsubnet(var.hvn_cidr_block, 0, 0) == 10 ||
      cidrsubnet(var.hvn_cidr_block, 0, 0) == 192 ||
      (cidrsubnet(var.hvn_cidr_block, 0, 0) >= 172 && cidrsubnet(var.hvn_cidr_block, 0, 0) <= 31)
    )
    error_message = "The CIDR block value must be a private IPv4 CIDR block within the RFC1918 address space (10.*.*.*, 192.168.*.*, 172.[16-31].*.*)."
  }

  validation {
    condition     = !cidrsubnetoverlap(var.hvn_cidr_block, "172.31.0.0/16")
    error_message = "The HVN CIDR block value must not overlap with the default Azure VNet CIDR block (172.31.0.0/16)."
  }
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
