# Create Proxmox VMs

resource "proxmox_vm_qemu" "kubernetes_nodes" {
  for_each = var.pvd_node_configs

  name        = each.key
  vmid        = each.value["vm_id"]
  target_node = "pve"                # Change to the desired Proxmox node
  clone       = "ubuntu-22-04-jammy" # Change to the name of the template or VM to clone from
  cores       = each.value["cores"]
  memory      = each.value["ram"]
  scsihw      = "virtio-scsi-single"
  tags        = "k3s"
  
  network {
    bridge    = "vmbr0"
    firewall  = false
    link_down = false
    model     = "virtio"
    tag       = 20

  }
  disks {
    scsi {
      scsi0 {
        disk {
          cache    = "writeback"
          size     = each.value["hard_drive"]
          backup   = true
          storage  = "old-lvm"
          iothread = true
        }

      }
    }
  }
}