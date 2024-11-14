resource "vault_policy" "azure-policy" {
  name = "standard-policy"

  policy = <<EOT
path "${vault_namespace.tenant.path}/azure/*" {
  capabilities = ["read","create","list","update"]
}

path "${vault_namespace.tenant.path}/${vault_mount.kvv2.path}/+/*" {
    capabilities = [ "create", "update", "read", "delete", "list" ]
}

path "${vault_namespace.tenant.path}/keymgmt/*" {
    capabilities = [ "create", "update", "read", "delete", "list" ]
}

path "${vault_namespace.tenant.path}/${vault_mount.kvv2.path}/metadata" {
    capabilities = [ "list" ]
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
