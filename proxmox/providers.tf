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
# This is the url to the proxmox environment, 8006 is the default port that the proxmox web interface runs on, the rest (/api2/json) is the service path
  pm_api_url = "https://pve.reinthal.me:8006/api2/json"

# This turns on debugging
  pm_debug = true

# Use this if your sever does not have https encryption
  pm_tls_insecure = true

# This is the API Token information we got before when we configured Proxmox. pm_api_token_id is the full token name from Proxmox. pm_api_token_secret is the token value from Proxmox.
  pm_api_token_id="tofuman@pve!killertofu"
  pm_api_token_secret=var.proxmox_api_token_secret
}