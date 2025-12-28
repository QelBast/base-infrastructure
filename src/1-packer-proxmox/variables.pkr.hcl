# Hyper-V
variable "switch_name" {
  type        = string
  description = "Hyper-V virtual switch"
  default     = "Qelb External Switch"
}
variable "vm_name" {
  type        = string
  description = "Name of the VM during Packer build"
  default     = "proxmox-hub-golden"
}
variable "mac" {
  type        = string
  default     = "00:15:5D:81:01:01"
}

# Resource Allocation
variable "memory" {
  type        = number
  description = "RAM in MB"
  default     = 6480 # 6GB
}
variable "cpus" {
  type        = number
  description = "CPU cores"
  default     = 4
}
variable "disk_size" {
  type        = number
  description = "VHD (disk) size in MB"
  default     = 20480 # 20GB
}

# ISO Configuration
variable "iso_url" {
  type        = string
  description = "URL for the ISO image"
  default     = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.2.0-amd64-netinst.iso"
}
variable "iso_checksum" {
  type        = string
  description = "Checksum for the ISO image"
  default     = "sha256:677c4d57aa034dc192b5191870141057574c1b05df2b9569c0ee08aa4e32125d"
}
variable "debian_version" {
  type        = string
  description = "Debian version. Release name"
  default     = "trixie"
}

# VM Configuration
variable "hostname" {
  type        = string
  description = "Hostname of the VM"
  default     = "vmhub"
}
variable "domain" {
  type        = string
  description = "Web domain of the VM"
  default     = "local"
}
variable "timezone" {
  type        = string
  description = "Timezone for the VM"
  default     = "Etc/UTC" # Europe/Berlin
}
variable "root_password" {
  type        = string
  description = "Root password for the VM"
  sensitive   = true
}

# User Configuration
variable "username" {
  type        = string
  description = "Username for the user"
  default     = "proxmox_admin"
}
variable "password" {
  type        = string
  description = "Password for the user"
  sensitive   = true
}
variable "fullname" {
  type        = string
  description = "Full name for the user"
  default     = "Proxmox Admin"
}

# YubiKey Configuration
variable "oath_key" {
  type        = string
  description = "YubiKey OATH secret"
  default     = "none"
  sensitive   = true
}
