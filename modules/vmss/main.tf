resource "azurerm_virtual_machine_scale_set" "main" {
  name                = "${var.component_name}-${var.env}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  upgrade_policy_mode = "Rolling"

  sku {
    name     = "Standard_B1s"
    tier     = "Standard"
    capacity = 2
  }

  storage_profile_os_disk {
    name          = "${var.component_name}-${var.env}"
    caching       = "ReadWrite"
    create_option = "FromImage"
    image         = var.image_id
  }

  os_profile {
    computer_name_prefix = "${var.component_name}-${var.env}"
    admin_username       = "devops"
    admin_password       = "DevOps@123456"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  network_profile {
    name    = "${var.component_name}-${var.env}"
    primary = true

    ip_configuration {
      name      = "${var.component_name}-${var.env}"
      primary   = true
      subnet_id = var.subnet_id
    }
  }

}