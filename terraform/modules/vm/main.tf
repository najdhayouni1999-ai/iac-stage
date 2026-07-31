resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.vm_name
  node_name = var.node_name

  clone {
    vm_id = var.template_id
    full  = true
  }

  cpu {
    cores = var.cpu_cores
  }

  memory {
    dedicated = var.memory_mb
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = var.disk_size
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${var.ip_address}/${var.ip_prefix}"
        gateway = var.gateway
      }
    }
    user_account {
      username = var.ssh_username
      keys     = [trimspace(file(var.ssh_public_key_path))]
    }
  }
}

