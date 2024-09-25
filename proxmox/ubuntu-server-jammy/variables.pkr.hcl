# Variable Definitions
variable proxmox_api_url {
    type = string
}

variable proxmox_api_token_id {
    type = string
}

variable proxmox_api_token_secret {
    type = string
    sensitive = true
}
variable node_configs {
    default = {
        "pve" = {storage_pool = "local-lvm", pool_type = "lvm", vm_id = 9100}, 
        "pvd" = {storage_pool = "local-zfs", pool_type = "zfs", vm_id = 9100}, 
        "pvc" = {storage_pool = "local-zfs", pool_type = "zfs", vm_id = 9300}
    }
}