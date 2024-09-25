# Create Proxmox VMs

data "local_file" "ssh_public_key" {
  filename = "./keys/vm.pub"
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_raw {
    data = <<-EOF
    #cloud-config
    users:
      - default
      - name: ubuntu
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
        - apt update
        - apt install -y qemu-guest-agent net-tools
        - timedatectl set-timezone America/Toronto
        - systemctl enable qemu-guest-agent
        - systemctl start qemu-guest-agent
        - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  for_each = toset(["pve", "pvd", "pvc"])
  content_type = "iso"
  datastore_id = "local"
  node_name    = each.value
  url          = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_vm" "k3s" {
  for_each = var.node_configs
  name                    = each.key
  node_name = each.value["node"]
  vm_id     = each.value["vm_id"]
  tags = ["k3s"]

  cpu {
    cores = each.value["cores"]
  }

  memory {
    dedicated = each.value["ram"]
  }


  initialization {
    datastore_id = each.value["datastore"]
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      username = "kog"
      keys     = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }

  disk {
    datastore_id = each.value["datastore"]
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image[each.value["node"]].id
    interface    = "virtio0"
    cache    = "writeback"
    iothread     = true
    discard      = "on"
    size         = each.value["hard_drive"]
  }

  user_data_file_id = proxmox_virtual_environment_file.cloud_config.id

  network_device {
    mac_address = each.value["mac_address"]
    bridge = each.value["bridge"]
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
