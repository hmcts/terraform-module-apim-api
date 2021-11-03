variable "product" {
  type        = string
  description = "Project Product name"
}
variable "env" {
  type        = string
  description = "Environment Name"
}
variable "department" {
  type        = string
  description = "HMCTS Department"
  default     = "sds"
  validation {
    condition     = var.department == "sds" || var.department == "cft"
    error_message = "HMCTS Department must be sds or cft."
  }
}

## Product
variable "product_id" {
  type        = string
  description = "APIM Product Display Name"
  default     = ""
}


## API
variable "api_name" {
  type        = string
  description = "APIM API Name"
}
variable "api_revision" {
  type        = string
  description = "APIM API Revision"
  default     = "1"
}
variable "api_protocols" {
  type        = list(string)
  description = "APIM API Protocols"
  default     = []
}
variable "api_service_url" {
  type        = string
  description = "APIM API Service URL"
  default     = ""
  validation {
    condition     = var.api_service_url == "" || regex("(https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|www\\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9]+\\.[^\\s]{2,}|www\\.[a-zA-Z0-9]+\\.[^\\s]{2,})", var.api_service_url)
    error_message = "Service URL should be a valid URL."
  }
}
variable "api_subscription_required" {
  type        = bool
  description = "APIM API subscription required"
  default     = false
}
variable "api_content_format" {
  type        = string
  description = "APIM API Content Format"

  validation {
    condition     = contains(["openapi", "openapi+json", "openapi+json-link", "openapi-link", "swagger-json", "swagger-link-json", "wadl-link-json", "wadl-xml", "wsdl", "wsdl-link"], var.api_content_format)
    error_message = "Content Format possible values are openapi, openapi+json, openapi+json-link, openapi-link, swagger-json, swagger-link-json, wadl-link-json, wadl-xml, wsdl and wsdl-link."
  }
}
variable "api_content_value" {
  type        = string
  description = "APIM API Value"
}

## Policy
variable "policy_xml_content" {
  type        = string
  description = "APIM API Policy Content"
  default     = ""
}
variable "policy_xml_link" {
  type        = string
  description = "APIM API Policy Link"
  default     = ""
  validation {
    condition     = var.policy_xml_link == "" || regex("(https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|www\\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9]+\\.[^\\s]{2,}|www\\.[a-zA-Z0-9]+\\.[^\\s]{2,})", var.policy_xml_link)
    error_message = "XML Link should be provided as a valid URL."
  }
}


variable "api_operations" {
  type = list(object({
    operation_id = string
    xml_content  = string
    xml_link     = string
    display_name = string
    method       = string
    url_template = string
    description  = string
  }))
  description = "Details of each API Operation"
  default     = []
}