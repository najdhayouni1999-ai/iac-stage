module "vm_web" {
  source = "./modules/vm"

  vm_name              = "web-01"
  ip_address            = "192.168.200.51"
  cpu_cores             = 2
  memory_mb              = 2048
  ssh_public_key_path    = "C:/Users/Lenovo/.ssh/id_ed25519.pub"
}

module "vm_app" {
  source = "./modules/vm"

  vm_name              = "app-01"
  ip_address            = "192.168.200.52"
  cpu_cores             = 2
  memory_mb              = 2048
  ssh_public_key_path    = "C:/Users/Lenovo/.ssh/id_ed25519.pub"
}

module "vm_db" {
  source = "./modules/vm"

  vm_name              = "db-01"
  ip_address            = "192.168.200.53"
  cpu_cores             = 2
  memory_mb              = 2048
  ssh_public_key_path    = "C:/Users/Lenovo/.ssh/id_ed25519.pub"
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tpl", {
    web_ip = module.vm_web.vm_ip
    app_ip = module.vm_app.vm_ip
    db_ip  = module.vm_db.vm_ip
  })
  filename = "${path.module}/inventory.ini"
}
