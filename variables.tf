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
  default     = null
}
variable "policy_xml_link" {
  type        = string
  description = "APIM API Policy Link"
  default     = null
}


variable "api_operations" {
  type = list(object({
    operation_id = string
    xml_content  = string
    display_name = string
    method       = string
    url_template = string
    description  = string
    headers = optional(list(object({
      name = string
      required = string
      type = string
      default_value = string
    })))
    query_parameters = optional(list(object({
      name = string
      required = string
      type = string
      default_value = string
    })))
    template_parameter = optional(object({
      name = string
      required = string
      type = string
      default_value = string
    }))
    response = optional(object({
      status_code = string
      description = string
    }))
  }))
  description = "Details of each API Operation"
  default     = []
}