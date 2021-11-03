# terraform-module-apim-api

This module is to create an API within an APIM

## Example

```terraform
module "apim_apis" {
  source      = "git::https://github.com/hmcts/terraform-module-apim-api"
  environment = "sbox"
  product     = "pip"
  department  = "sds"

  api_name                  = "links-api"
  api_revision              = "1"
  api_protocols             = ["https"]
  api_service_url           = "https://www.backendservice.com"
  api_subscription_required = false
  api_content_format        = "openapi"
  api_content_value         = "{Open API Content}"


  policy_xml_content = "<xml></xml>"
  api_operations = [
    {
      operation_id = "opt-1"
      xml_content  = "<xml></xml>"
      display_name = "Example Operation"
      method       = "GET"
      url_template = "/example"
      description  = "Operation as example"
    }
  ]
}
```
