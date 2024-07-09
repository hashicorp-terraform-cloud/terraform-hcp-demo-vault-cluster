# HCP Vault Dedicated - Terraform Demo

This repository contains Terraform code to provision an HashiCorp Vault Dedicated cluster on HashiCorp Cloud Platform (HCP).

## Prerequisites

- Terraform 1.7.x or later
- An HCP account

### An HCP Project-level Service Principal 
This should be a Project-level Service Principal with Contributor rights as per https://developer.hashicorp.com/hcp/docs/hcp/admin/iam/service-principals

The following environment variables should be captured either locally (for local execution) or in a HCP Terraform Variable Set (for remote execution)

   ```bash
   HCP_CLIENT_ID = ...
   HCP_CLIENT_SECRET = ...
   HCP_PROJECT_ID = ...
   ```

The HCP Project ID can be captured from the Project Settings page - https://developer.hashicorp.com/hcp/docs/hcp/admin/projects#create-a-project


## HCP Terraform Usage

1. **Sign up for HCP Terraform**: If you haven't already, sign up for a Terraform Cloud account at https://app.terraform.io/signup/account.

2. **Create a new Workspace**: Navigate to the Workspaces section in the Terraform Cloud dashboard and click on "New Workspace". Choose the "Version control workflow" option.


3. **Connect to Version Control System (VCS)**: Select your VCS (like GitHub, GitLab, Bitbucket, etc.) and authorise Terraform Cloud to access your repositories.

4. **Select your Repository**: Choose the repository where your Terraform configuration is located: 

    ```bash
    https://github.com/hashicorp-terraform-cloud/terraform-hcp-demo-vault-cluster
    ```

5. **Configure Settings**: Give your workspace a name, and configure the Terraform version and other settings as per your requirements.

6. **Add Mandatory Variables**: Navigate to the "Variables" section of your workspace and add your mandatory Terraform variables. For sensitive values like API keys, make sure to mark them as sensitive.

    ```bash
    cluster_id = ...
    hvn_cidr_block = ...
    ```
7. **Add Optional Variables**: Navigate to the "Variables" section of your workspace and add your optional Terraform variables. For sensitive values like API keys, make sure to mark them as sensitive.

    ```bash
    cluster_ip_allowlist = ...
    ```

8. **Queue a Plan**: Click on "Queue Plan" to have Terraform Cloud run `terraform plan` on your configuration.

9. **Apply the Plan**: If the plan looks good, click on "Confirm & Apply" to have Terraform Cloud run `terraform apply`.

Remember to check the "Runs" section of your workspace to monitor the progress of your plans and applies.

For more detailed instructions, refer to the [HCP Terraform documentation](https://developer.hashicorp.com/terraform/cloud-docs).

## Local Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/hashicorp-terraform-cloud/terraform-hcp-demo-vault-cluster.git
    ```

2. Navigate to the repository directory:

    ```bash
    cd terraform-hcp-demo-vault-cluster
    ```

3. Initialize Terraform:

    ```bash
    terraform init
    ```

4. Create a Terraform plan:

    ```bash
    terraform plan
    ```

5. Apply the Terraform plan:

    ```bash
    terraform apply
    ```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) | ~> 0.94.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | 0.94.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcp_hvn.hcp-hvn](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/hvn) | resource |
| [hcp_vault_cluster.hcp-vault-cluster](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster) | resource |
| [hcp_vault_cluster_admin_token.bootstrap-token](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster_admin_token) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_provider"></a> [cloud\_provider](#input\_cloud\_provider) | value of the cloud provider for the cluster. see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#cloud_provider for more information. | `string` | `"azure"` | no |
| <a name="input_cloud_region"></a> [cloud\_region](#input\_cloud\_region) | value of the cloud region for the cluster. see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#region for more information. | `string` | `"westeurope"` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | the id of the cluster to create. must be unique within the account. | `string` | n/a | yes |
| <a name="input_cluster_ip_allowlist"></a> [cluster\_ip\_allowlist](#input\_cluster\_ip\_allowlist) | list of objects containing address and description for the ip allowlist | <pre>list(object({<br>    address     = string<br>    description = string<br>  }))</pre> | <pre>[<br>  {<br>    "address": "0.0.0.0/0",<br>    "description": "allow all traffic"<br>  }<br>]</pre> | no |
| <a name="input_cluster_tier"></a> [cluster\_tier](#input\_cluster\_tier) | value of the tier for the cluster. see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#tier for more information. | `string` | `"standard_small"` | no |
| <a name="input_expose_public_endpoint"></a> [expose\_public\_endpoint](#input\_expose\_public\_endpoint) | value of the public endpoint for the cluster. see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#public_endpoint for more information. | `bool` | `true` | no |
| <a name="input_hvn_cidr_block"></a> [hvn\_cidr\_block](#input\_hvn\_cidr\_block) | The CIDR block for the HashiCorp Virtual Network. Should not overlap with any existing networks for peering purposes. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bootstrap_token"></a> [bootstrap\_token](#output\_bootstrap\_token) | n/a |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_hvn_id"></a> [hvn\_id](#output\_hvn\_id) | n/a |
| <a name="output_private_endpoint_url"></a> [private\_endpoint\_url](#output\_private\_endpoint\_url) | n/a |
| <a name="output_public_endpoint_url"></a> [public\_endpoint\_url](#output\_public\_endpoint\_url) | n/a |
<!-- END_TF_DOCS -->