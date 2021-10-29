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
variable "product_display_name" {
  type        = string
  description = "APIM Product Display Name"
  default     = ""
}
variable "product_discription" {
  type        = string
  description = "APIM Product Discription"
  default     = ""
}
variable "product_subscription_required" {
  type        = bool
  description = "APIM Product Subscription Required"
  default     = false
}
variable "product_published" {
  type        = bool
  description = "APIM Product Published"
  default     = true
}
variable "product_approval_required" {
  type        = bool
  description = "APIM Product Approval Required"
  default     = false
}

## APIs
variable "apis" {
  type = list(object({
    name                  = string
    revision              = string
    protocols             = string
    service_url           = string
    subscription_required = bool
    content_format        = string
    content_value         = string
  }))
  description = "Details of each API"
  default     = []

  validation {
    condition     = [for s in var.apis : contains(["", "http", "https"], s.protocols)]
    error_message = "Protocal possible values are http and https."
  }
  validation {
    condition     = [for s in var.apis : contains(["openapi", "openapi+json", "openapi+json-link", "openapi-link", "swagger-json", "swagger-link-json", "wadl-link-json", "wadl-xml", "wsdl", "wsdl-link"], s.content_format)]
    error_message = "Content Format possible values are openapi, openapi+json, openapi+json-link, openapi-link, swagger-json, swagger-link-json, wadl-link-json, wadl-xml, wsdl and wsdl-link."
  }
  validation {
    condition     = [for s in var.apis : regex("*-link-*", s.content_format) ? regex("(https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|www\\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9]+\\.[^\\s]{2,}|www\\.[a-zA-Z0-9]+\\.[^\\s]{2,})", s.content_value) : s.content_value != ""]
    error_message = "If Content Format is '*-link-*' then Content Value must be a valid URL, else it can be an inline string."
  }
  validation {
    condition     = [for s in var.apis : regex("(https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|www\\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9]+\\.[^\\s]{2,}|www\\.[a-zA-Z0-9]+\\.[^\\s]{2,})", s.service_url)]
    error_message = "Service URL should be a valid URL."
  }
}

variable "api_policies" {
  type = list(object({
    api_name    = string
    xml_content = string
    xml_link    = string
  }))
  description = "Details of each API Policy"
  default     = []

  validation {
    condition     = [for s in var.api_policies : s.xml_link != "" ? regex("(https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|www\\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9]+\\.[^\\s]{2,}|www\\.[a-zA-Z0-9]+\\.[^\\s]{2,})", s.xml_link) : s.xml_content != ""]
    error_message = "XML Content or Link should be provided."
  }
}

## API User
variable "user_id" {
  type        = string
  description = "APIM User ID"
  default     = ""
}
variable "user_has_password" {
  type        = bool
  description = "APIM User requires password"
  default     = false
}
