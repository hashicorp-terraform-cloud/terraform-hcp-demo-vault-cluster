/**
  This file contains the variables that are used in the HashiCorp Cloud Platform (HCP) Vault Cluster demo.
  The variables are organized into the following sections:
  - General Variables
  - HashiCorp Virtual Network (HVN) variables
  - Vault Cluster variables
  - Azure Secrets Engine and Azure Auth Method variables
  - AppRole auth method variables
  For more information on the variables used in this demo, see the README.md file.
 */

/**
  General Variables
*/

variable "default_token_ttl" {
  description = "The default auth token TTL for the Vault cluster, in seconds. Defaults to 1 hour."
  type        = number
  default     = 3600
}

variable "default_token_max_ttl" {
  description = "The default auth token max TTL for the Vault cluster, in seconds. Defaults to 24 hours."
  type        = number
  default     = 86400
}


/*
  HashiCorp Virtual Network (HVN)

  CIDR Block Recommendations

  If the CIDR block values for your HVN and VNets overlap, then you will not be able to establish a connection. Ensure that any VNets you plan to connect do not have overlapping values.
  The default HVN CIDR block value does not overlap with the default CIDR block value for Azure VNets (172.31.0.0/16). However, if you are planning to use this HVN in production, we recommend adding a custom value instead of using the default.
  The CIDR block value must be a private IPv4 CIDR block within the RFC1918 address space (10.*.*.*, 192.168.*.*, 172.[16-31].*.*).
  The CIDR block value must be the first IP address of the desired CIDR block.
  The CIDR block value must end between /16 and /25.
*/
variable "hvn_cidr_block" {
  description = "The CIDR block for the HashiCorp Virtual Network. Should not overlap with any existing networks for peering purposes."
  type        = string

  validation {
    condition     = try(cidrsubnet(var.hvn_cidr_block, 0, 0), null) != null
    error_message = "The CIDR block value must be a valid subnet."
  }

  validation {
    condition     = cidrhost(var.hvn_cidr_block, 0) == element(split("/", var.hvn_cidr_block), 0)
    error_message = "The CIDR block value must be the first IP address of the desired CIDR block."
  }

  validation {
    condition     = can(regex("^.*\\/(1[6-9]|2[0-5])$", var.hvn_cidr_block))
    error_message = "The CIDR block value must end between /16 and /25."
  }
}

/**
Vault Cluster Variables
*/
variable "cluster_tier" {
  description = "value of the tier for the cluster. see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#tier for more information."
  type        = string
  default     = "dev"
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

/**
Azure Secrets Engine and Azure Auth Method Variables
*/
// General
variable "tenant_id" {
  description = "The tenant ID of your Azure account for use with both the Azure Auth Method and Azure Secrets Engine."
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID of your Azure account for use with both the Azure Auth Method and Azure Secrets Engine."
  type        = string
}

// Auth Method
variable "auth_client_id" {
  description = "The client ID of the Azure service principal for use with the Azure Auth Method."
  type        = string
}

variable "auth_client_secret" {
  description = "The client secret of the Azure service principal for use with the Azure Auth Method."
  type        = string
  sensitive   = true
}

variable "auth_ado_bound_spns" {
  description = "The list of Azure DevOps service principals to bind to the Azure Auth Method for ADO."
  type        = list(string)
}

// Secrets Engine
variable "secret_client_id" {
  description = "The client ID of the Azure service principal for use with the Azure Secrets Engine."
  type        = string
}

variable "secret_client_secret" {
  description = "The client secret of the Azure service principal for use with the Azure Secrets Engine."
  type        = string
  sensitive   = true
}

/**
AppRole Auth Method Variables
*/

/**
JWT Auth Method Variables
*/

variable "hcptf_organisation_id" {
  description = "value of the Terraform Cloud organization ID"
  type        = string
}
