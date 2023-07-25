output "name" {
  value = azurerm_api_management_api.apim_api.name
}
output "id" {
  value = azurerm_api_management_api.apim_api.id
}

output "policy_id" {
  value = azurerm_api_management_api_policy.apim_api_policy.id
}

output "apim_api_operation_ids" {
  value = [ for apim_operation in azurerm_api_management_api_operation.apim_api_operation : {
    api_operation_id = apim_operation.id
    operation_id = apim_operation.operation_id
  }]
}