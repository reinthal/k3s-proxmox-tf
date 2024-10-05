variable "proxmox_endpoint" {
  type = string
}
variable "proxmox_api_token" {
  type = string
}

variable "proxmox_username" {
  type = string
}

variable "ssh_keys" {
  default = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDG2HQMrYddPMA9CnLIPH4b0Iasg5LkQDW/BNR8wGsbbZ9++v41Tggri5Yq6V5EBcpFVLdEcRgPbRqPk10QLAVXilDBqz6sMUrLyUt5KXhG37X9x4ro0F1/87I0CY3OrDnfm09uclc4tH5gJyeLfiHGOUKZx4malacdWQFCdN7JBHqG0QE++WTilOFerlfQMJULnt75u3zJE5f+IjG7xdjSbx3tr2F7MYMVS21LY1S5UIldl7JHxWz4OaT9CD0+n2t+718tUT7rsLKG34V5yZwMbwOU3D0sjR++umO0hsT4yFRK4/U9Wj17QoLVub14FFUuQDVStuNmr97IgDnn/cSRgStdikksbrQQB0eFmhQf4+hp1uBoTGKE/hgEwG2Bio+xQjCDwLrIgWAUvWiJ7rIbrib3DtchHrK5/MHa09Xfkv692AuhIfmLdxL1FdXCosRf2NOZJ1iQNybqhMgyaifJA7CyIf3/ty0SQMM+Mwt60FDpzGFHrxCx1by7u/gUKV1L97RMekp4pM2Z+Q9fi/ySOurYXW0AsAr1kkCicF4y2MEX/qL1Tse+6ywgACucLGnP/cEvn5YYu8KOcQwZDiKr2YscWH3XOZIE5rqKnXxembEdDh1vNHjL9RQotA7EdZ5C0WbtqYwgVHH1CwlpHtTo1gVN18YIyKl4ZL1pl6DGOw== openpgp:0x9A29FF08
    EOF

}

# Define variables for the VM configurations
variable "node_configs" {
  default = {
    "pvc-server-1" = { clone_id = 9100, datastore = "local-zfs", node = "pvc", vm_id = 2002, cores = 4, ram = 4096, hard_drive = 50, mac_address ="bc:24:11:87:8d:c7" , address = "10.22.20.2/24", bridge = "k3s" }
    "pvc-agent-1"  = { clone_id = 9100,datastore = "local-zfs", node = "pvc", vm_id = 2003, cores = 20, ram = 8096, hard_drive = 100, mac_address ="82:b0:13:fe:4d:32", address = "10.22.20.3/24", bridge = "k3s" }
    "pvc-agent-2" = { clone_id = 9100 ,datastore = "local-zfs", node = "pvc", vm_id = 2004, cores = 20, ram = 8096, hard_drive = 100, mac_address ="be:0f:4d:3e:c6:03" , address = "10.22.20.4/24", bridge = "k3s" }
    "pvd-server-2"  = { clone_id = 9200,datastore = "local-zfs", node = "pvd", vm_id = 2005, cores = 4, ram = 4096, hard_drive = 100, mac_address ="42:69:ce:f4:12:ae" , address = "10.22.20.5/24", bridge = "k3s" }
    "pvd-agent-3"  = { clone_id = 9200 ,datastore = "local-zfs", node = "pvd", vm_id = 2006, cores = 4, ram = 4096, hard_drive = 50, mac_address ="0a:03:1a:99:a7:c4" , address = "10.22.20.6/24", bridge = "k3s" }
    "pve-server-3" = { clone_id = 9300 ,datastore = "local-lvm", node = "pve", vm_id = 2007, cores = 4, ram = 4096, hard_drive = 50, mac_address ="26:e4:6c:4e:01:1b" , address = "10.22.20.7/24", bridge = "k3s" }
    "pve-agent-4"  = { clone_id = 9300 ,datastore = "local-lvm", node = "pve", vm_id = 2008, cores = 4, ram = 6096, hard_drive = 100, mac_address ="1a:9b:20:dc:d6:c8" , address = "10.22.20.8/24", bridge = "k3s" }
  }
}


