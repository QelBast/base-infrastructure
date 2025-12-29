#!/bin/bash

set -eux

echo "Installing Proxmox VE..."

sudo sh -c "echo \"deb http://download.proxmox.com/debian/pve $VERSION pve-no-subscription\" \
  > /etc/apt/sources.list.d/pve.list"

sudo apt update && sudo apt full-upgrade -y

sudo apt install -y proxmox-ve postfix open-iscsi ifupdown2 pve-headers git packer make

# Remove os-prober/nag
sudo apt remove os-prober -y
echo "Disabling subscription nag"
sudo sed -i.bak 's|data.status !== "Active"|false|g' /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js

# Configure network interfaces (bridge)
sudo bash -c 'cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto vmbr0
iface vmbr0 inet dhcp
  bridge-ports none
  bridge-stp off
  bridge-fd 0
EOF'
sudo ip link set vmbr0 up

# Start and enable the firewall
sudo pve-firewall start
sudo pve-firewall enable

# Ensure user is enabled
sudo pveum user modify qelb@pam --enable 1

echo "Removing Debian kernel..."
sudo update-grub
sudo apt remove -y linux-image-amd64 || true

sudo systemctl enable --now pve-cluster pveproxy pvedaemon pve-ha-manager

# Enable TFA for user (YubiKey)
if [ -n "$KEY" ] && [ "$KEY" != "none" ]; then
  echo "Configuring OATH..."
  # Configure TFA realm
  sudo pveum realm modify pve --tfa 'type=webauthn,challenge-path=/webauthn/challenge'
  # For user: Adding TFA key (but for auto — need YubiKey serial or OATH; WebAuthn registers in UI/browser).
  sudo apt install -y oathtool  # If TOTP fallback

  # Example for user TFA (replace key with your YubiKey OATH secret):
  sudo pveum user modify $USER@pve --tfa "type=oath,step=30,digits=6,key=$KEY"
fi

echo "Proxmox installed successfully"
exit 0
