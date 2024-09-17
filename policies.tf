resource "vault_policy" "azure-policy" {
  name = "standard-policy"

  policy = <<EOT
path "admin/${vault_namespace.tenant.path}/azure/*" {
  capabilities = ["read","create","list","update"]
}

path "admin/${vault_namespace.tenant.path}/kvv2/+/{{identity.entity.name}}/*" {
    capabilities = [ "create", "update", "read", "delete", "list" ]
}
EOT

}

resource "vault_policy" "hcp-tf-policy" {
  name = "hcp-tf-policy"

  policy = <<EOT
path "*" {
  capabilities = ["read","create","update","delete","list","patch"]
}
EOT

}
