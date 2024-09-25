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
variable "pvc_node_configs" {
  default = {
    "pvc-server-1" = { vm_id = 2002, cores = 4, ram = 4096, hard_drive = 50, address = "10.22.20.2/24" }
    "pvc-agent-1"  = { vm_id = 2003, cores = 12, ram = 8096, hard_drive = 100, address = "10.22.20.3/24" }
    "pvc-agent-2" = { vm_id = 2004, cores = 12, ram = 8096, hard_drive = 100 address = "10.22.20.4/24" }
  }
}
variable "pvd_node_configs" {
  default = {
    "pvd-server-2"  = { vm_id = 2005, cores = 4, ram = 4096, hard_drive = 100, address = "10.22.20.5/24" }
    "pvd-agent-3"  = { vm_id = 2006, cores = 4, ram = 4096, hard_drive = 50, address = "10.22.20.6/24" }
    
  }
}

variable "pve_node_configs" {
  default = {
    "pve-server-3" = { vm_id = 2007, cores = 4, ram = 4096, hard_drive = 50, address = "10.22.20.7/24" }
    "pve-agent-4"  = { vm_id = 2008, cores = 4, ram = 4096, hard_drive = 100, address = "10.22.20.8/24" }
    "pve-agent-5"  = { vm_id = 2009, cores = 4, ram = 8096, hard_drive = 100, address = "10.22.20.9/24" }
  }

}

