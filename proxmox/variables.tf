variable proxmox_endpoint {
  type = string
}
variable proxmox_ssh_username {
  type = string
}
variable proxmox_api_token {
  type = string
}

variable ssh_keys {
default = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDG2HQMrYddPMA9CnLIPH4b0Iasg5LkQDW/BNR8wGsbbZ9++v41Tggri5Yq6V5EBcpFVLdEcRgPbRqPk10QLAVXilDBqz6sMUrLyUt5KXhG37X9x4ro0F1/87I0CY3OrDnfm09uclc4tH5gJyeLfiHGOUKZx4malacdWQFCdN7JBHqG0QE++WTilOFerlfQMJULnt75u3zJE5f+IjG7xdjSbx3tr2F7MYMVS21LY1S5UIldl7JHxWz4OaT9CD0+n2t+718tUT7rsLKG34V5yZwMbwOU3D0sjR++umO0hsT4yFRK4/U9Wj17QoLVub14FFUuQDVStuNmr97IgDnn/cSRgStdikksbrQQB0eFmhQf4+hp1uBoTGKE/hgEwG2Bio+xQjCDwLrIgWAUvWiJ7rIbrib3DtchHrK5/MHa09Xfkv692AuhIfmLdxL1FdXCosRf2NOZJ1iQNybqhMgyaifJA7CyIf3/ty0SQMM+Mwt60FDpzGFHrxCx1by7u/gUKV1L97RMekp4pM2Z+Q9fi/ySOurYXW0AsAr1kkCicF4y2MEX/qL1Tse+6ywgACucLGnP/cEvn5YYu8KOcQwZDiKr2YscWH3XOZIE5rqKnXxembEdDh1vNHjL9RQotA7EdZ5C0WbtqYwgVHH1CwlpHtTo1gVN18YIyKl4ZL1pl6DGOw== openpgp:0x9A29FF08
    EOF

}

# Define variables for the VM configurations
variable "pvc_node_configs" {
  default = {
   # "dutch-c" = { vm_id = 2013, cores = 4, ram = 4096, hard_drive = 50, macaddr = "42:69:CE:F4:12:AE" }
  #  "revy-c"  = { vm_id = 2023, cores = 12, ram = 8096, hard_drive = 100, macaddr = "1a:9b:20:dc:d6:c8"}
  }
}
variable "pvd_node_configs" {
  default = {
    "dutch-c" = { vm_id = 2013, cores = 4, ram = 4096, hard_drive = 50, macaddr = "42:69:CE:F4:12:AE" }
    "dutch-d" = { vm_id = 2012, cores = 4, ram = 4096, hard_drive = 50, macaddr = "be:0f:4d:3e:c6:03" }
    "revy-d"  = { vm_id = 2022, cores = 4, ram = 4096, hard_drive = 100 , macaddr = "26:e4:6c:4e:01:1b"}
  }
}

variable "pve_node_configs" {
  default = {
    "dutch-e" = { vm_id = 2011, cores = 4, ram = 4096, hard_drive = 50 , macaddr = "82:b0:13:fe:4d:32"}
    "revy-e"  = { vm_id = 2021, cores = 4, ram = 4096, hard_drive = 100 , macaddr = "0a:03:1a:99:a7:c4"}
    "revy-c"  = { vm_id = 2023, cores = 4, ram = 8096, hard_drive = 100, macaddr = "1a:9b:20:dc:d6:c8"}
  }

}

