variable "switch_name" {
  description = "Hyper-V virtual switch"
  type        = string
  default     = "Qelb External Switch"
}

variable "vm_name" {
  description = "Name of the VM during Packer build"
  type        = string
  default     = "proxmox-hub-golden"
}

variable "memory" {
  description = "RAM in MB"
  type        = number
  default     = 6480 # 6GB
}

variable "cpus" {
  description = "CPU cores"
  type        = number
  default     = 4
}

variable "disk_size" {
  description = "Disk size in MB"
  type        = number
  default     = 20000 # 20GB
}

variable "iso_url" {
  type        = string
  default     = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.2.0-amd64-netinst.iso"
}

variable "iso_checksum" {
  type        = string
  default     = "none"
}

variable "ssh_username" {
  type        = string
  default     = "root"
}
variable "ssh_password" {
  type        = string
  default     = "P@ssw0rd123"
}

variable "hostname" {
  type        = string
  default     = "proxmox-hub"
}

variable "ip_address" {
  type        = string
  default     = "192.168.1.90"
}

variable "gateway" {
  type        = string
  default     = "192.168.1.1"
}

variable "netmask" {
  type        = string
  default     = "24"
}

variable "mac" {
  type        = string
  default     = "00:15:5D:81:01:01"
}