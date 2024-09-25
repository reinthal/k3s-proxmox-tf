# Create Proxmox VMs

data "local_file" "ssh_public_key" {
  filename = "./keys/vm.pub"
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "pve"
  url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = "test-ubuntu"
  node_name = "pve"

  initialization {

    ip_config {
      ipv4 {
        address = "10.22.12.10/24"
        gateway = "10.22.12.1"
      }
    }

    user_account {
      username = "kog"
      keys     = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  network_device {
    bridge = "dev"
  }
}

/**
resource "proxmox_vm_qemu" "pvc_kubernetes_nodes" {
  for_each = var.pvc_node_configs

  name                    = each.key
  vmid                    = each.value["vm_id"]
  target_node             = "pvc"                # Change to the desired Proxmox node
  clone                   = "ubuntu-22-04-jammy" # Change to the name of the template or VM to clone from
  cores                   = each.value["cores"]
  memory                  = each.value["ram"]
  scsihw                  = "virtio-scsi-single"
  tags                    = "k3s"
  os_type                 = "cloud-init"
  ipconfig0               = "ip=dhcp,ip6=dhcp"
  cloudinit_cdrom_storage = "local-zfs"
  ssh_user                = "kog"
  sshkeys                 = var.ssh_keys

  network {
    bridge    = "k3s"
    firewall  = false
    link_down = false
    model     = "virtio"
    macaddr = each.value["macaddr"]

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

  name                    = each.key
  vmid                    = each.value["vm_id"]
  target_node             = "pvd"                # Change to the desired Proxmox node
  clone                   = "ubuntu-22-04-jammy" # Change to the name of the template or VM to clone from
  cores                   = each.value["cores"]
  memory                  = each.value["ram"]
  scsihw                  = "virtio-scsi-single"
  tags                    = "k3s"
  os_type                 = "cloud-init"
  ipconfig0               = "ip=dhcp,ip6=dhcp"
  cloudinit_cdrom_storage = "local-zfs"
  ssh_user                = "kog"
  sshkeys                 = var.ssh_keys
  network {
    bridge    = "k3s"
    firewall  = false
    link_down = false
    model     = "virtio"
    macaddr = each.value["macaddr"]
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

  name                    = each.key
  vmid                    = each.value["vm_id"]
  target_node             = "pve"                # Change to the desired Proxmox node
  clone                   = "ubuntu-22-04-jammy" # Change to the name of the template or VM to clone from
  cores                   = each.value["cores"]
  memory                  = each.value["ram"]
  scsihw                  = "virtio-scsi-single"
  tags                    = "k3s"
  os_type                 = "cloud-init"
  ipconfig0               = "ip=dhcp,ip6=dhcp"
  cloudinit_cdrom_storage = "old-lvm"
  ssh_user                = "kog"
  sshkeys                 = var.ssh_keys

  network {
    bridge    = "k3s"
    firewall  = false
    link_down = false
    model     = "virtio"
    macaddr = each.value["macaddr"]
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

*/
