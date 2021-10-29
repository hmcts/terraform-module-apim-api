output "product_id" {
  value = azurerm_api_management_product.apim_product.id
}

output "api_names" {
  value = toset([
    for api in azurerm_api_management_api.apim_apis : api.name
  ])
}
output "api_ids" {
  value = toset([
    for api in azurerm_api_management_api.apim_apis : api.id
  ])
}

output "api_policy_ids" {
  value = toset([
    for api in azurerm_api_management_api_policy.apim_api_policies : api.id
  ])
}

output "user_id" {
  value = azurerm_api_management_user.apim_user[0].id
}
output "user_user_id" {
  value = azurerm_api_management_user.apim_user[0].user_id
}
output "user_password" {
  value     = random_password.user_password.result
  sensitive = true
}
output "user_state" {
  value = azurerm_api_management_user.apim_user[0].state
}

output "subscription_id" {
  value = azurerm_api_management_subscription.apim_subscription.id
}
output "subscription_primary_key" {
  value     = azurerm_api_management_subscription.apim_subscription.primary_key
  sensitive = true
}