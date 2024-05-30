resource_group_name     = "ntier-qa"
azurerm_virtual_network = "azure_ntier_vnet"
location                = "eastus"
azure_ntier_cidr        = "10.10.0.0/16"
#azure_subnet            = ["10.10.0.0/24"]
#subnet_address_prefixes = "10.10.%g.0/24" we removed this for now as we dont need now as we used cidrsubnet function in network.tf

subnet_names = ["web", "app", "db", "mgmt"]
web_nsg_config = {
  name = "webnsg"
  rules = [{
    name                       = "openhttp"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "80"
    access                     = "Allow"
    priority                   = 300
    direction                  = "Inbound"

    },
    {
      name                       = "openssh"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "22"
      access                     = "Allow"
      priority                   = 310
      direction                  = "Inbound"

    },
    {
      name                       = "open5000"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "5000"
      access                     = "Allow"
      priority                   = 320
      direction                  = "Inbound"

  }]

}

app_nsg_config = {
  name = "appnsg"
  rules = [{
    name                       = "open8080"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "8080"
    access                     = "Allow"
    priority                   = 300
    direction                  = "Inbound"

    },
    {
      name                       = "open22"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "22"
      access                     = "Allow"
      priority                   = 310
      direction                  = "Inbound"

    },
    {
      name                       = "open6000"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "6000"
      access                     = "Allow"
      priority                   = 320
      direction                  = "Inbound"

  }]

}