data "keycloak_realm" "realm" {
  realm   = var.realm
}
resource "keycloak_openid_client" "vault" {

  realm_id      = data.keycloak_realm.realm.id
  client_id     = var.vault_client_id
  name          = var.vault_client_id
  description = "The keycloak client that is used by vault to access the client secrets"
  enabled       = true
  access_type              = "CONFIDENTIAL"
  service_accounts_enabled = true

  client_secret = var.vault_client_secret

}

data "keycloak_openid_client" "realm_management" {
  realm_id = data.keycloak_realm.realm.id
  client_id     = "realm-management"
}

data "keycloak_role" "view_clients" {
  realm_id = data.keycloak_realm.realm.id
  name     = "view-clients"
  client_id = data.keycloak_openid_client.realm_management.id
}

resource "keycloak_user_roles" "vault_client_roles" {
  realm_id = data.keycloak_realm.realm.id
  user_id  = keycloak_openid_client.vault.service_account_user_id

  role_ids = [
    data.keycloak_role.view_clients.id
  ]
}
