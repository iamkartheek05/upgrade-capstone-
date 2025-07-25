resource "azurerm_linux_virtual_machine" "azure_vm" {
  name                = "azure-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B2ms"
  admin_username      = "kartheek"
  network_interface_ids = [azurerm_network_interface.nic.id]

  admin_ssh_key {
    username   = "kartheek"
    public_key = file("~/.ssh/project_key.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  tags = {
    Name = "AzureAppMachine"
  }
}
