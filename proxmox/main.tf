# Create Proxmox VMs

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
  sshkeys                 = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpbCzlfMjlenM4qgaT4WWrVhtabWCBLN7X+JaXgInu40aiDEtKVyy6cTyyZmPv1BvHi1Xyg9coJxvlTv66EJZkzrf+UUvHTZhgcog6ZqAqOblxbk7wg2w+im/2TypVj5dvU8YRFz7dLcjA8tP0kyzXaPWEsA1KbVPV1jM+7ut41NldG7es+qxN0F9gvwmnHqS3ej2ajfGlXboGvWA4mcEF03YB9ZZKn7L2QTNRoajx1b83s+UYbRSSTi2xbSXNVmBGAKmO+TH0T+/1s4dR0inUzPX2UzpCXbwMCFwy0eNeO/MVQLoPdyVVc8YjTB8+nImnFRiaP6nTR0F3e+mQ3Xq1XBKyUpHe6tbxPL4coQOkciEcK8lq89pzbzc14ZVbIpnC35XZ2K3Bxk5U/8SjXpaxJ1SPBWOR7gn9XpeLZxOqwefR+K0OsQfTst8D7WRP8MxLYlBVzXnkKlewAYuwf6neQk0+ZqEmD4EdXwjY9Az+sDR676xgWQrfFcvRVRGIUWs= kog@Alexs-MacBook-Pro.local
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDakbytHYHeMYF4d37T3uOa5ILBFZ+LV25ViUMKiI5slozK56aRsZJrEPbQuLCt48uNkmY4yR1QztY3JCCysPRp4Co8Pi7YuYmd6DmU1k2f27JVno/K8DaGH7miPBLjcmoQguZFV460yirs7Rd4swQa9OMfBCtQ2w/rBga71yG9h6qNvF5csbBx8En8LIADvTsu+F61qQfQxhR37iUwozKmsbfMTiDu+p+n3T38RG8vuqBz3PSEXLQxLVel4ZdFcUvFz+yJc5qyRumTZO68QuWEI/D+FGSld8OHzlvUdELhhoK/986VmMhxR69Mv+ILa/7r0B3EkYO+xQqtHouf9s7GUyg2eSIjisbpVzZIEHcMx95bilJQkkIFHuFPX9gx595XZy0G3e7Wtc+HqDk/tJOFNXWKcO/BAgSCcqF6tZBsA7aJLH46pBhqxfxfykS9iMm3kTeFRZNmKEMQ9JRJnaaeyTxeEpX2sYwU4bqTaJojOJcHSKGGlfHefpkfzBnQNFk= kog@battlestation
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDA6oK4Nf4KfPAhwYLnVZZIOjOITkWfNRhtpik9i1hT3dPaqcx/H4b/wGnBBaOppX/UOgyvZ83caavmkZf3Y06Nippeo50zxbH0DrWk27x8/8yZ9io7R4L4ea6VwSrRnZJ72rGTwiErXcLnuBj9kikUFqi1oPpTYF99OPyRSnDt0ZPuaPEu7K6ha8iHvbZe68iVBO8dQfuWg5nKfO2hB2B4pf5qYw3XkzStv3CJbLTKkrP5B6jPonsS/UT+FQDbI/6LSJ4N2ctJzNJFKw3QVUrSYoLXweDNBibbKhUFW0UvnSxSx0vrdL6QzF/9Li2zrDQLankhF0r47L8MhLVFloRpcHMgPy2R9xRzEFBokpbEv6TIzvw824FfhnO5cEjDU6p4tLW6/e5v9XmmsBtv7poZYMcZbcyHIyVeGrNIldyHJv2JjItNaW2xI5szh0b/5K4qQW4ycg5k73eB8IcnBZcL5zdl9OFDz4ixfxkq51iFtcN9QIOhuXb8kpSmEELtGpc= kog@build
  EOF


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
  sshkeys                 = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpbCzlfMjlenM4qgaT4WWrVhtabWCBLN7X+JaXgInu40aiDEtKVyy6cTyyZmPv1BvHi1Xyg9coJxvlTv66EJZkzrf+UUvHTZhgcog6ZqAqOblxbk7wg2w+im/2TypVj5dvU8YRFz7dLcjA8tP0kyzXaPWEsA1KbVPV1jM+7ut41NldG7es+qxN0F9gvwmnHqS3ej2ajfGlXboGvWA4mcEF03YB9ZZKn7L2QTNRoajx1b83s+UYbRSSTi2xbSXNVmBGAKmO+TH0T+/1s4dR0inUzPX2UzpCXbwMCFwy0eNeO/MVQLoPdyVVc8YjTB8+nImnFRiaP6nTR0F3e+mQ3Xq1XBKyUpHe6tbxPL4coQOkciEcK8lq89pzbzc14ZVbIpnC35XZ2K3Bxk5U/8SjXpaxJ1SPBWOR7gn9XpeLZxOqwefR+K0OsQfTst8D7WRP8MxLYlBVzXnkKlewAYuwf6neQk0+ZqEmD4EdXwjY9Az+sDR676xgWQrfFcvRVRGIUWs= kog@Alexs-MacBook-Pro.local
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDakbytHYHeMYF4d37T3uOa5ILBFZ+LV25ViUMKiI5slozK56aRsZJrEPbQuLCt48uNkmY4yR1QztY3JCCysPRp4Co8Pi7YuYmd6DmU1k2f27JVno/K8DaGH7miPBLjcmoQguZFV460yirs7Rd4swQa9OMfBCtQ2w/rBga71yG9h6qNvF5csbBx8En8LIADvTsu+F61qQfQxhR37iUwozKmsbfMTiDu+p+n3T38RG8vuqBz3PSEXLQxLVel4ZdFcUvFz+yJc5qyRumTZO68QuWEI/D+FGSld8OHzlvUdELhhoK/986VmMhxR69Mv+ILa/7r0B3EkYO+xQqtHouf9s7GUyg2eSIjisbpVzZIEHcMx95bilJQkkIFHuFPX9gx595XZy0G3e7Wtc+HqDk/tJOFNXWKcO/BAgSCcqF6tZBsA7aJLH46pBhqxfxfykS9iMm3kTeFRZNmKEMQ9JRJnaaeyTxeEpX2sYwU4bqTaJojOJcHSKGGlfHefpkfzBnQNFk= kog@battlestation
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDA6oK4Nf4KfPAhwYLnVZZIOjOITkWfNRhtpik9i1hT3dPaqcx/H4b/wGnBBaOppX/UOgyvZ83caavmkZf3Y06Nippeo50zxbH0DrWk27x8/8yZ9io7R4L4ea6VwSrRnZJ72rGTwiErXcLnuBj9kikUFqi1oPpTYF99OPyRSnDt0ZPuaPEu7K6ha8iHvbZe68iVBO8dQfuWg5nKfO2hB2B4pf5qYw3XkzStv3CJbLTKkrP5B6jPonsS/UT+FQDbI/6LSJ4N2ctJzNJFKw3QVUrSYoLXweDNBibbKhUFW0UvnSxSx0vrdL6QzF/9Li2zrDQLankhF0r47L8MhLVFloRpcHMgPy2R9xRzEFBokpbEv6TIzvw824FfhnO5cEjDU6p4tLW6/e5v9XmmsBtv7poZYMcZbcyHIyVeGrNIldyHJv2JjItNaW2xI5szh0b/5K4qQW4ycg5k73eB8IcnBZcL5zdl9OFDz4ixfxkq51iFtcN9QIOhuXb8kpSmEELtGpc= kog@build
  EOF

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
  sshkeys                 = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpbCzlfMjlenM4qgaT4WWrVhtabWCBLN7X+JaXgInu40aiDEtKVyy6cTyyZmPv1BvHi1Xyg9coJxvlTv66EJZkzrf+UUvHTZhgcog6ZqAqOblxbk7wg2w+im/2TypVj5dvU8YRFz7dLcjA8tP0kyzXaPWEsA1KbVPV1jM+7ut41NldG7es+qxN0F9gvwmnHqS3ej2ajfGlXboGvWA4mcEF03YB9ZZKn7L2QTNRoajx1b83s+UYbRSSTi2xbSXNVmBGAKmO+TH0T+/1s4dR0inUzPX2UzpCXbwMCFwy0eNeO/MVQLoPdyVVc8YjTB8+nImnFRiaP6nTR0F3e+mQ3Xq1XBKyUpHe6tbxPL4coQOkciEcK8lq89pzbzc14ZVbIpnC35XZ2K3Bxk5U/8SjXpaxJ1SPBWOR7gn9XpeLZxOqwefR+K0OsQfTst8D7WRP8MxLYlBVzXnkKlewAYuwf6neQk0+ZqEmD4EdXwjY9Az+sDR676xgWQrfFcvRVRGIUWs= kog@Alexs-MacBook-Pro.local
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDakbytHYHeMYF4d37T3uOa5ILBFZ+LV25ViUMKiI5slozK56aRsZJrEPbQuLCt48uNkmY4yR1QztY3JCCysPRp4Co8Pi7YuYmd6DmU1k2f27JVno/K8DaGH7miPBLjcmoQguZFV460yirs7Rd4swQa9OMfBCtQ2w/rBga71yG9h6qNvF5csbBx8En8LIADvTsu+F61qQfQxhR37iUwozKmsbfMTiDu+p+n3T38RG8vuqBz3PSEXLQxLVel4ZdFcUvFz+yJc5qyRumTZO68QuWEI/D+FGSld8OHzlvUdELhhoK/986VmMhxR69Mv+ILa/7r0B3EkYO+xQqtHouf9s7GUyg2eSIjisbpVzZIEHcMx95bilJQkkIFHuFPX9gx595XZy0G3e7Wtc+HqDk/tJOFNXWKcO/BAgSCcqF6tZBsA7aJLH46pBhqxfxfykS9iMm3kTeFRZNmKEMQ9JRJnaaeyTxeEpX2sYwU4bqTaJojOJcHSKGGlfHefpkfzBnQNFk= kog@battlestation
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDA6oK4Nf4KfPAhwYLnVZZIOjOITkWfNRhtpik9i1hT3dPaqcx/H4b/wGnBBaOppX/UOgyvZ83caavmkZf3Y06Nippeo50zxbH0DrWk27x8/8yZ9io7R4L4ea6VwSrRnZJ72rGTwiErXcLnuBj9kikUFqi1oPpTYF99OPyRSnDt0ZPuaPEu7K6ha8iHvbZe68iVBO8dQfuWg5nKfO2hB2B4pf5qYw3XkzStv3CJbLTKkrP5B6jPonsS/UT+FQDbI/6LSJ4N2ctJzNJFKw3QVUrSYoLXweDNBibbKhUFW0UvnSxSx0vrdL6QzF/9Li2zrDQLankhF0r47L8MhLVFloRpcHMgPy2R9xRzEFBokpbEv6TIzvw824FfhnO5cEjDU6p4tLW6/e5v9XmmsBtv7poZYMcZbcyHIyVeGrNIldyHJv2JjItNaW2xI5szh0b/5K4qQW4ycg5k73eB8IcnBZcL5zdl9OFDz4ixfxkq51iFtcN9QIOhuXb8kpSmEELtGpc= kog@build
  EOF

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
