# Create Proxmox VMs

resource "proxmox_vm_qemu" "pvc_kubernetes_nodes" {
  for_each = var.pvc_node_configs

  name        = each.key
  vmid        = each.value["vm_id"]
  target_node = "pvc"                # Change to the desired Proxmox node
  clone       = "ubuntu-22-04-jammy" # Change to the name of the template or VM to clone from
  cores       = each.value["cores"]
  memory      = each.value["ram"]
  scsihw      = "virtio-scsi-single"
  tags        = "k3s"
  os_type   = "cloud-init"

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
          storage  = "local-zfs"
          iothread = true
        }

      }
    }
  }
}
resource "proxmox_vm_qemu" "pvd_kubernetes_nodes" {
  for_each = var.pvd_node_configs

  name        = each.key
  vmid        = each.value["vm_id"]
  target_node = "pvd"                # Change to the desired Proxmox node
  clone       = "ubuntu-22-04-jammy" # Change to the name of the template or VM to clone from
  cores       = each.value["cores"]
  memory      = each.value["ram"]
  scsihw      = "virtio-scsi-single"
  tags        = "k3s"
  os_type   = "cloud-init"

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
          storage  = "local-zfs"
          iothread = true
        }

      }
    }
  }
}
resource "proxmox_vm_qemu" "pve_kubernetes_nodes" {
  for_each = var.pve_node_configs

  name        = each.key
  vmid        = each.value["vm_id"]
  target_node = "pve"                # Change to the desired Proxmox node
  clone       = "ubuntu-22-04-jammy" # Change to the name of the template or VM to clone from
  cores       = each.value["cores"]
  memory      = each.value["ram"]
  scsihw      = "virtio-scsi-single"
  tags        = "k3s"
  os_type   = "cloud-init"

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