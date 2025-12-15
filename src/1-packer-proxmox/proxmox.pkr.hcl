packer {
  required_version = ">= 1.9.0"

  required_plugins {
    hyperv = {
      version = " >= 1.1.5"
      source  = "github.com/hashicorp/hyperv"
    }
  }
}

source "hyperv-iso" "proxmox" {
  iso_url       = var.iso_url
  iso_checksum  = var.iso_checksum

  vm_name       = var.vm_name
  memory        = var.memory
  cpus          = var.cpus
  disk_size     = var.disk_size

  generation = 2
  enable_secure_boot = false
  guest_additions_mode = "disable"
  mac_address = var.mac # for ssh dhcp connect
  switch_name   = var.switch_name
  
  communicator = "ssh"
  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  ssh_timeout        = "30m"

  iso_target_path     = "${path.root}/packer_cache"

  output_directory = "${path.root}/../../VHDs/${var.vm_name}"

  http_directory = "${path.root}/http"

  shutdown_command = "shutdown -h now"
  shutdown_timeout = "40m"

  boot_wait = "10s"
  boot_command = [
    "<esc><wait>",
    "<down><down><enter><wait10>",
    "<down><down><down><down><down><enter><wait60>",
    "http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "<enter>"
  ]
}

build {
  name    = "proxmox-golden"
  sources = ["source.hyperv-iso.proxmox"]

  provisioner "shell" {
    script = "${path.root}/scripts/install-proxmox.sh"
    expect_disconnect = true
  }
}
