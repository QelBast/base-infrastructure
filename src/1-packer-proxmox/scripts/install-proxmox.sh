#!/bin/bash
set -eux

echo "Installing Proxmox VE..."

echo "deb http://download.proxmox.com/debian/pve trixie pve-no-subscription" \
  > /etc/apt/sources.list.d/pve.list

#wget -qO /etc/apt/trusted.gpg.d/proxmox.gpg \
#  https://enterprise.proxmox.com/debian/proxmox-release-trixie.gpg

apt update
apt full-upgrade -y

apt install -y proxmox-ve postfix open-iscsi

systemctl enable pveproxy
systemctl enable pvedaemon

echo "Removing Debian kernel..."
apt remove -y linux-image-amd64 || true

echo "Proxmox installed successfully"

echo "Load node golden-image creation configs"
git clone https://github.com/
exit 0
