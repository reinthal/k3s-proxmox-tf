terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.65.0"
    }
  }
}

# Define the Proxmox provider
provider "proxmox" {

  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  # because self-signed TLS certificate is in use
  insecure = true

  ssh {
    agent    = true
    username = var.proxmox_username
  }

}