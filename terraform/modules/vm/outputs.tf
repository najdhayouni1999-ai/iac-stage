output "vm_id" {
  value       = proxmox_virtual_environment_vm.vm.vm_id
  description = "VMID Proxmox de la VM creee"
}

output "vm_name" {
  value       = proxmox_virtual_environment_vm.vm.name
  description = "Nom de la VM"
}

output "vm_ip" {
  value       = var.ip_address
  description = "Adresse IP de la VM"
}
