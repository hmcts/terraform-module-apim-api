# terraform-module-apim-api

This module is to create products within an Api Manager with APIs

## Example

```terraform
module "apim_apis" {
  source        = "git::https://github.com/hmcts/terraform-module-apim-api"
  environment   = "sbox"
  product       = "pip"
  department    = "sds"

  apis = [
    {
      name                  = "links-api"
      revision              = "1"
      protocols             = "https"
      service_url           = "https://www.backendservice.com"
      subscription_required = false
      content_format        = "openapi"
      content_value         = "{Open API Content}" 
    }
  ]

  api_policies = [
    {
      api_name    = "links-api"
      xml_content = "<xml></xml>"
    }
  ]
}
```

## Optional User
You can also assign a user to the API, which will be added to the subscription as well.

```terraform
  user_id           = "4nc3098ey32xy2" #must be unique
  user_has_password = true
```