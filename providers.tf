terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

# Define the Proxmox provider
provider "proxmox" {
  pm_api_url      = "https://pve:8006/api2/json"
  pm_tls_insecure = true             # Set to true if you're using self-signed certificates
  pm_user         = "root@pam"       # Change to your Proxmox username
  pm_password     = var.pve-password # Change to your Proxmox password
}