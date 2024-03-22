variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type = string
}

# Define variables for the VM configurations
variable "pvc_node_configs" {
  default = {
    "dutch-3" = { vm_id = 2013, cores = 4, ram = 4096, hard_drive = 50 }
    "rock-2"  = { vm_id = 2032, cores = 12, ram = 8096, hard_drive = 100 }
    "boris-3" = { vm_id = 2043, cores = 12, ram = 4096, hard_drive = 300 }
  }
}
variable "pvd_node_configs" {
  default = {
    "dutch-2" = { vm_id = 2012, cores = 4, ram = 4096, hard_drive = 50 }
    "revy-2"  = { vm_id = 2022, cores = 4, ram = 8096, hard_drive = 50 }
    "rock-1"  = { vm_id = 2031, cores = 4, ram = 4096, hard_drive = 100 }
    "boris-2" = { vm_id = 2042, cores = 4, ram = 4096, hard_drive = 300 }
  }
}

variable "pve_node_configs" {
  default = {
    "dutch-1" = { vm_id = 2011, cores = 4, ram = 4096, hard_drive = 50 }
    "revy-1"  = { vm_id = 2021, cores = 4, ram = 4096, hard_drive = 50 }
    "boris-1" = { vm_id = 2041, cores = 4, ram = 4096, hard_drive = 300 }
  }

}

