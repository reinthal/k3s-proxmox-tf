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
    "dutch-c" = { vm_id = 2010, cores = 4, ram = 4096, hard_drive = 50, macaddr = "1e:48:22:26:b7:8a" }
    "revy-c"  = { vm_id = 2020, cores = 12, ram = 8096, hard_drive = 600 , macaddr = "1a:9b:20:dc:d6:c8" }
  }
}
variable "pvd_node_configs" {
  default = {
    "dutch-d" = { vm_id = 2011, cores = 4, ram = 4096, hard_drive = 50 , macaddr = "be:0f:4d:3e:c6:03"}
    "revy-d"  = { vm_id = 2021, cores = 4, ram = 8096, hard_drive = 600 , macaddr = "26:e4:6c:4e:01:1b"}
  }
}

variable "pve_node_configs" {
  default = {
    "dutch-e" = { vm_id = 2012, cores = 4, ram = 4096, hard_drive = 50 , macaddr = "82:b0:13:fe:4d:32" }
    "revy-e"  = { vm_id = 2022, cores = 4, ram = 8096, hard_drive = 600 , macaddr = "0a:03:1a:99:a7:c4" }
  }

}

