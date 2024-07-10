resource "vault_policy" "azure-policy" {
  name = "azure-policy"

  policy = <<EOT
path "azure/*" {
  capabilities = ["read","create","list","update"]
}
EOT

}
