resource "vault_policy" "azure-policy" {
  name = "azure-policy"

  policy = <<EOT
path "azure/*" {
  capabilities = ["read","create","list","update"]
}

path "kvv2/+/*" {
  capabilities = ["read"]
}
EOT

}

resource "vault_policy" "agent-management-policy" {
  name = "agent-management-policy"

  policy = <<EOT
path "auth/approle/role/agent-role/secret-id" {
  capabilities = ["read","create","update"]
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
