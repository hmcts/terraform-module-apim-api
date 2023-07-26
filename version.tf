terraform {
  backend "azurerm" {}

  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      version = "3.42.0"
    }
  }
}

provider "azurerm" {
  features {}
}
