variable "pve-password" {
  description = "pve password"
  sensitive   = true
}

# Define variables for the VM configurations
variable "pvc_node_configs" {
  default = {
    "dutch-3" = { vm_id = 2013, cores = 4, ram = 4096, hard_drive = 50 }
    "revy-3"  = { vm_id = 2023, cores = 8, ram = 8096, hard_drive = 50 }
    "rock-2"  = { vm_id = 2032, cores = 8, ram = 4096, hard_drive = 250 }
    "boris-1" = { vm_id = 2041, cores = 8, ram = 4096, hard_drive = 250 }
  }
}
variable "pvd_node_configs" {
  default = {
    "dutch-2" = { vm_id = 2012, cores = 4, ram = 4096, hard_drive = 50 }
    "revy-2"  = { vm_id = 2022, cores = 4, ram = 8096, hard_drive = 50 }
    "rock-1"  = { vm_id = 2031, cores = 4, ram = 4096, hard_drive = 200 }
    "boris-2" = { vm_id = 2042, cores = 4, ram = 4096, hard_drive = 200 }
  }
}

variable "pve_node_configs" {
  default = {
    "dutch-1" = { vm_id = 2011, cores = 4, ram = 4096, hard_drive = 50 }
    "revy-1"  = { vm_id = 2021, cores = 4, ram = 4096, hard_drive = 50 }
  }

}

