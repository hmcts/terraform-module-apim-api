locals {
  env       = (var.env == "aat") ? "stg" : (var.env == "sandbox") ? "sbox" : "${(var.env == "perftest") ? "test" : "${var.env}"}"
  apim_name = "${var.department}-api-mgmt-${local.env}"
  apim_rg   = var.department == "sds" ? "ss-${local.env}-network-rg" : var.env == "sbox" || var.env == "perftest" || var.env == "aat" || var.env == "ithc" ? "cft-${var.env}-network-rg" : "aks-infra-${var.env}-rg"

  api_name = "${var.product}-${var.api_name}"
}

resource "azurerm_api_management_api" "apim_api" {
  name                = local.api_name
  resource_group_name = local.apim_rg
  api_management_name = local.apim_name
  revision            = var.api_revision
  display_name        = "${var.product} ${var.api_name} API"
  path                = var.product
  protocols           = var.api_protocols

  service_url = var.api_service_url

  subscription_required = var.api_subscription_required

  import {
    content_format = var.api_content_format
    content_value  = var.api_content_value
  }
}

resource "azurerm_api_management_api_policy" "apim_api_policy" {
  api_name            = azurerm_api_management_api.apim_api.name
  api_management_name = azurerm_api_management_api.apim_api.api_management_name
  resource_group_name = azurerm_api_management_api.apim_api.resource_group_name
  xml_content         = var.policy_xml_content
  xml_link            = var.policy_xml_link
}

resource "azurerm_api_management_api_operation" "apim_api_operation" {
  for_each            = { for operation in var.api_operations : operation.operation_id => operation }
  operation_id        = each.value.operation_id
  api_name            = azurerm_api_management_api.apim_api.name
  api_management_name = azurerm_api_management_api.apim_api.api_management_name
  resource_group_name = azurerm_api_management_api.apim_api.resource_group_name
  display_name        = each.value.display_name
  method              = each.value.method
  url_template        = each.value.url_template
  description         = each.value.description

  request {
    dynamic "header" {
      for_each = (each.value.headers == null) ? [] : each.value.headers
      content {
        name     = header.value["name"]
        required = header.value["required"]
        type     = header.value["type"]
        default_value = (header.value["default_value"] == null) ? null : header.value["default_value"]
      }
    }
    dynamic "query_parameter" {
      for_each = (each.value.query_parameters == null) ? [] : each.value.query_parameters
      content {
        name     = query_parameter.value["name"]
        required = query_parameter.value["required"]
        type     = query_parameter.value["type"]
        default_value = (query_parameter.value["default_value"] == null) ? null : query_parameter.value["default_value"]
      }
    }
  }
  dynamic "response" {
    for_each = (each.value.response == null) ? [] : [1]
    content {
      status_code = each.value.response.status_code
      description = (each.value.response.description == null) ? null : each.value.response.description
    }
  }
  dynamic "template_parameter" {
    for_each = (each.value.template_parameter == null) ? [] : [1]
    content {
      name     = each.value.template_parameter.name
      required = each.value.template_parameter.required
      type     = each.value.template_parameter.type
      default_value = (each.value.template_parameter.default_value == null) ? null : each.value.template_parameter.default_value
    }
  }
}

resource "azurerm_api_management_api_operation_tag" "apim_api_tag" {
  for_each         = { for operation in var.api_operations : operation.operation_id => operation if can(operation.tag.name) }
  name             = each.value.tag.name
  api_operation_id = resource.azurerm_api_management_api_operation.apim_api_operation[each.value.operation_id].id
  display_name     = each.value.tag.display_name
}

resource "azurerm_api_management_api_operation_policy" "apim_api_operation_policies" {
  for_each            = { for operation in var.api_operations : operation.operation_id => operation }
  operation_id        = each.value.operation_id
  api_name            = azurerm_api_management_api.apim_api.name
  api_management_name = azurerm_api_management_api.apim_api.api_management_name
  resource_group_name = azurerm_api_management_api.apim_api.resource_group_name
  xml_content         = each.value.xml_content

  depends_on = [azurerm_api_management_api_operation.apim_api_operation]
}

data "azurerm_api_management_product" "apim_product" {
  product_id          = "${var.product}-product-${local.env}"
  resource_group_name = local.apim_rg
  api_management_name = local.apim_name
}

resource "azurerm_api_management_product_api" "product" {
  api_name            = azurerm_api_management_api.apim_api.name
  product_id          = data.azurerm_api_management_product.apim_product.product_id
  api_management_name = azurerm_api_management_api.apim_api.api_management_name
  resource_group_name = azurerm_api_management_api.apim_api.resource_group_name
}

