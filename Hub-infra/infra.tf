terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

terraform {
  backend "azurerm" {
    storage_account_name = var.storage_account_name
    container_name       = "tfstate"
    key                  = "${var.prefix}.hub.terraform.tfstate"

    # rather than defining this inline, the Access Key can also be sourced
    # from an Environment Variable - more information is available below.
    access_key = var.access_key
  }
}

module "hub-infra" {

  source = "github.com/sajipoochira/TerraformModules.git/terraform/Modules/HUB-infra/"

  storage_account_name = var.storage_account_name
  prefix = var.prefix
  access_key = var.access_key


  location = var.location

  network_resource_group = var.network_resource_group

  vnet = var.vnet
  resource_group_names = var.resource_group_names

  network_settings = var.network_settings


  tags = var.tags

}

