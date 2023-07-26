
# Project Title

A brief description of what this project does and who it's for

# terraform-module-apim-api

This module is to create an API within an APIM

## Example

```terraform
module "apim_apis" {
  source      = "git::https://github.com/hmcts/terraform-module-apim-api"
  env         = "sbox"
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
      headers      = [{
        "name": "example-header",
        "required": "true",
        "type": "string",
        "default_value": "any"
      }]
      query_parameters = [{
        "name": "example_query_paramter",
        "required": "true",
        "type": "string",
        "default_value": "any"
      }]
      template_parameter = {
        "name": "example_template_parameter",
        "required": "true",
        "type": "string",
        "default_value": "any"
      }
      response = {
        "status_code": "200",
        "description": "any"
      }

    }
  ]
}
```
## Optional arguments
This module also supports following arguments:

### Request (optional)
This can be used to add request arguments for each api operations. Arguments which can be added to request are header and query_parameter.

#### header (optional)
Header section is optional. You can add any header which is required by api operation. A header block supports the following:

|Variable|Description| Required? |
|:----------|:-------------|-----------|
|name|The Name of this Header.| Yes       |
|required|Is this Header Required?| Yes       |
|type|The Type of this Header, such as a string.| Yes       |
|default_value|The default value for this Header.| No        |

#### query_parameter (optional)
Query parameter section is optional. You can add any query_parameter which is required by api operation. A query_parameter block supports the following:

|Variable|Description| Required? |
|:----------|:-------------|-----------|
|name|The Name of this Query Parameter.| Yes       |
|required|Is this Query Parameter Required?| Yes       |
|type|The Type of this Query Parameter, such as a string.| Yes       |
|default_value|The default value for this Query Parameter.| No        |

### Response (optional)
This can be used to add the response of each api operation. Response block supports the following:
|Variable|Description| Required? |
|:----------|:-------------|-----------|
|status_code|The HTTP Status Code. i.e. 201| Yes       |
|description|IA description of the HTTP Response, which may include HTML tags.| No      |

### Template Parameter (optional)
This can be used to add the template paramter of each api operation. Template parameter block supports the following:
|Variable|Description| Required? |
|:----------|:-------------|-----------|
|name|The Name of this Template Parameter.| Yes       |
|required|Is this Template Parameter Required?| Yes       |
|type|The Type of this Template Parameter, such as a string.| Yes       |
|default_value|The default value for this Template Parameter.| No        |

### Tag (optional)
This can be used to add tags for each api operations. Following information needs to be provided for the tags:

|Variable|Description| Required? |
|:----------|:-------------|-----------|
|name|The name which should be used for this API Management API Operation Tag. The name must be unique for each api operation.| Yes       |
|display_name|The display name of the API Management API Operation Tag.| No 