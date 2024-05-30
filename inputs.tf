variable "resource_group_name" {
  type    = string
  default = "ntierresg"

}

variable "azurerm_virtual_network" {
  type        = string
  default     = "azure_ntier_vnet"
  description = "This is vnet cidr"

}

variable "location" {
  type        = string
  default     = "eastus"
  description = "This is resource group location"

}

variable "azure_ntier_cidr" {
  type        = string
  default     = "10.10.0.0/16"
  description = "This is azure vnet"

}

#As we dont need this address_prefixes when we use cidrsunet function so we put it in comments whole subnet_address_prefixes" block
#variable "subnet_address_prefixes" {
#  type = string
#  #type        = list(string)
#  default = "10.10.%g.0/24"
#  #default     = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24"]
#  description = "These are address subnet network ranges"
#
#
#}

variable "subnet_names" {
  type        = list(string)
  default     = ["web", "app", "db"]
  description = "These are subnet network names"

}

variable "web_nsg_config" {
  type = object({
    name = string
    rules = list(object({
      name                       = string
      protocol                   = string
      source_address_prefix      = string
      source_port_range          = string
      destination_port_range     = string
      destination_address_prefix = string
      priority                   = string
      access                     = string
      direction                  = string

    }))
  })

}

# we dont need to write default values here so we commented as below
# default = {
#   name = "webnsg"
#   rules = [{
#     access = "Allow"
#     destination_address_prefix = "*"
#     destination_port_range = "80"
#     direction = "Inbound"
#     name = "openhttp"
#     priority = "300"
#     protocol = "Tcp"
#     source_address_prefix = "*"
#     source_port_range = "*"
#   },
#     {
#     access = "Allow"
#     destination_address_prefix = "*"
#     destination_port_range = "22"
#     direction = "Inbound"
#     name = "openssh"
#     priority = "310"
#     protocol = "Tcp"
#     source_address_prefix = "*"
#     source_port_range = "*"
#   }]


# }

variable "app_nsg_config" {
  type = object({
    name = string
    rules = list(object({
      name                       = string
      protocol                   = string
      source_address_prefix      = string
      source_port_range          = string
      destination_port_range     = string
      destination_address_prefix = string
      priority                   = string
      access                     = string
      direction                  = string

    }))
  })

}