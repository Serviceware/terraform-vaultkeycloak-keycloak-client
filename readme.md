# Terraform Module for Vault Keycloak Terraform Provider



```hcl

module "keycloak_vault_config" {

  source = "Serviceware/vaultkeycloak/keycloak-client"
  realm           = "my-realm"
  vault_client_id = "vault"

}

```