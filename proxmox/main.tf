# Create Proxmox VMs

data "local_file" "ssh_public_key" {
  filename = "./keys/vm.pub"
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  for_each = toset(["pve", "pvd", "pvc"])
  content_type = "snippets"
  datastore_id = "local"
  node_name    = each.value

  source_raw {
    data = <<-EOF
    #cloud-config
    users:
      - default
      - name: kog
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
    user_data_file_id = proxmox_virtual_environment_file.cloud_config[each.value["node"]].id
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

  

  network_device {
    mac_address = each.value["mac_address"]
    bridge = each.value["bridge"]
  }
}
