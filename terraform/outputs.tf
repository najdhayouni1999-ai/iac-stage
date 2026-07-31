output "web_ip" {
  value = module.vm_web.vm_ip
}

output "app_ip" {
  value = module.vm_app.vm_ip
}

output "db_ip" {
  value = module.vm_db.vm_ip
}
