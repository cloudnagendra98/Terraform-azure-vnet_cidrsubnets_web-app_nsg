resource "azurerm_virtual_network" "ntier_vnet" {
  name                = "azure_ntier_vnet"
  resource_group_name = azurerm_resource_group.ntier_resg.name
  address_space       = [var.azure_ntier_cidr]
  location            = azurerm_resource_group.ntier_resg.location

  depends_on = [
    azurerm_resource_group.ntier_resg
  ]
}

resource "azurerm_subnet" "subnets" {
  #count                = 3
  #count = length(var.subnet_address_prefixes)
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.ntier_resg.name
  virtual_network_name = azurerm_virtual_network.ntier_vnet.name
  address_prefixes     = [cidrsubnet(var.azure_ntier_cidr, 8, count.index)]
  #address_prefixes     = [format(var.subnet_address_prefixes, count.index)]
  #address_prefixes = [var.subnet_address_prefixes[count.index]]

  depends_on = [
    azurerm_resource_group.ntier_resg,
    azurerm_virtual_network.ntier_vnet
  ]

}

resource "azurerm_network_security_group" "webnsg" {
  name                = var.web_nsg_config.name
  resource_group_name = azurerm_resource_group.ntier_resg.name
  location            = azurerm_resource_group.ntier_resg.location

  depends_on = [
    azurerm_resource_group.ntier_resg
  ]

}

# resource "azurerm_network_security_group" "webnsg" {
#   name = "webnsg"
#   resource_group_name = azurerm_resource_group.ntier_resg.name
#   location = azurerm_resource_group.ntier_resg.location

#   depends_on = [
#      azurerm_resource_group.ntier_resg
#       ]

# }

resource "azurerm_network_security_rule" "rules" {
  count                       = length(var.web_nsg_config.rules)
  name                        = var.web_nsg_config.rules[count.index].name
  resource_group_name         = azurerm_resource_group.ntier_resg.name
  network_security_group_name = azurerm_network_security_group.webnsg.name
  protocol                    = var.web_nsg_config.rules[count.index].protocol
  source_address_prefix       = var.web_nsg_config.rules[count.index].source_address_prefix
  source_port_range           = var.web_nsg_config.rules[count.index].source_port_range
  destination_port_range      = var.web_nsg_config.rules[count.index].destination_port_range
  priority                    = var.web_nsg_config.rules[count.index].priority
  direction                   = var.web_nsg_config.rules[count.index].direction
  access                      = var.web_nsg_config.rules[count.index].access
  destination_address_prefix  = var.web_nsg_config.rules[count.index].destination_address_prefix



  # name = "openhttp"
  # resource_group_name = azurerm_resource_group.ntier_resg.name
  # network_security_group_name = azurerm_network_security_group.webnsg.name
  # protocol = "Tcp"
  # source_address_prefix = "*"
  # source_port_range = "*"
  # destination_port_range = "80"
  # priority = 300
  # direction = "Inbound"
  # access = "Allow"
  # destination_address_prefix = "*"

  depends_on = [
    azurerm_network_security_group.webnsg
  ]

}


#As we have used count and length above so dont need to write below script ; put in comments 
# resource "azurerm_network_security_rule" "webnsgrule_ssh" {
#   name = "openssh"
#   resource_group_name = azurerm_resource_group.ntier_resg.name
#   network_security_group_name = azurerm_network_security_group.webnsg.name
#   protocol = "Tcp"
#   source_address_prefix = "*"
#   source_port_range = "*"
#   destination_port_range = "22"
#   priority = 310
#   direction = "Inbound"
#   access = "Allow"
#   destination_address_prefix = "*"

#   depends_on = [
#      azurerm_network_security_group.webnsg 
#      ]

# }

resource "azurerm_network_security_group" "appnsg" {
  name                = var.app_nsg_config.name
  resource_group_name = azurerm_resource_group.ntier_resg.name
  location            = azurerm_resource_group.ntier_resg.location

  depends_on = [
    azurerm_resource_group.ntier_resg
  ]

}

resource "azurerm_network_security_rule" "appnsgrules" {
  count                       = length(var.app_nsg_config.rules)
  name                        = var.app_nsg_config.rules[count.index].name
  resource_group_name         = azurerm_resource_group.ntier_resg.name
  network_security_group_name = azurerm_network_security_group.appnsg.name
  protocol                    = var.app_nsg_config.rules[count.index].protocol
  source_address_prefix       = var.app_nsg_config.rules[count.index].source_address_prefix
  source_port_range           = var.app_nsg_config.rules[count.index].source_port_range
  destination_port_range      = var.app_nsg_config.rules[count.index].destination_port_range
  priority                    = var.app_nsg_config.rules[count.index].priority
  direction                   = var.app_nsg_config.rules[count.index].direction
  access                      = var.app_nsg_config.rules[count.index].access
  destination_address_prefix  = var.app_nsg_config.rules[count.index].destination_address_prefix

  depends_on = [
    azurerm_network_security_group.appnsg
  ]

}