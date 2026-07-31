variable "vm_name" {
  type        = string
  description = "Nom de la VM"
}

variable "node_name" {
  type        = string
  description = "Nom du node Proxmox cible"
  default     = "proxmox"
}

variable "template_id" {
  type        = number
  description = "VMID du template cloud-init a cloner"
  default     = 9000
}

variable "cpu_cores" {
  type        = number
  description = "Nombre de coeurs CPU"
  default     = 2
}

variable "memory_mb" {
  type        = number
  description = "Memoire allouee en Mo"
  default     = 2048
}

variable "ip_address" {
  type        = string
  description = "Adresse IPv4 de la VM"
}

variable "ip_prefix" {
  type        = number
  description = "Prefixe reseau CIDR"
  default     = 24
}

variable "gateway" {
  type        = string
  description = "Passerelle par defaut"
  default     = "192.168.200.2"
}

variable "ssh_username" {
  type        = string
  description = "Utilisateur cree via cloud-init"
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Chemin vers la cle publique SSH"
}
variable "disk_size" {
  type        = number
  description = "Taille du disque principal en Go"
  default     = 10
}
