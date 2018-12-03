# Create virtual machine
resource "azurerm_virtual_machine" "jenkins-slave" {
  name                  = "jenkins-slave-${count.index}"
  location              = "eastus"
  resource_group_name   = "${var.rg_name}"
  network_interface_ids = ["${var.ni_ids}"]
  vm_size               = "Standard_DS1_v2"
  count                 = "${var.servers}"

  # provisioner "chef" {
  #   run_list        = ["cookbook::recipe"]
  #   node_name       = "webserver1"
  #   server_url      = "https://chef.company.com/organizations/org1"
  #   recreate_client = true
  #   user_name       = "admin"
  #   user_key        = "${file("../bork.pem")}"
  #   ssl_verify_mode = ":verify_none"
  # }

  storage_os_disk {
    name              = "myOsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  os_profile {
    computer_name  = "jenkins-slave"
    admin_username = "*****"
    admin_password = "****"
  }

  # os_profile_linux_config {
  #   # disable_password_authentication = true
  #
  #   ssh_keys {
  #     path     = "/home/azureuser/.ssh/authorized_keys"
  #     key_data = "ssh-rsa AAAAB3Nz{snip}hwhqT9h"
  #   }
  # }

  tags {
    environment = "jeknins slave"
  }
}
