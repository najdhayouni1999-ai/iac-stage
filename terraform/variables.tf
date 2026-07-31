variable "proxmox_endpoint" {
  type        = string
  description = "URL de l'API Proxmox"
}

variable "proxmox_api_token" {
  type        = string
  description = "Token API Terraform (user@pve!tokenid=secret)"
  sensitive   = true
}
