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
    "dutch-c" = { vm_id = 2013, cores = 4, ram = 4096, hard_drive = 50 }
    "revy-c"  = { vm_id = 2023, cores = 12, ram = 8096, hard_drive = 100 }
  }
}
variable "pvd_node_configs" {
  default = {
    "dutch-d" = { vm_id = 2012, cores = 4, ram = 4096, hard_drive = 50 }
    "revy-d"  = { vm_id = 2022, cores = 4, ram = 8096, hard_drive = 100 }
  }
}

variable "pve_node_configs" {
  default = {
    "dutch-e" = { vm_id = 2011, cores = 4, ram = 4096, hard_drive = 50 }
    "revy-e"  = { vm_id = 2021, cores = 4, ram = 4096, hard_drive = 100 }
  }

}

