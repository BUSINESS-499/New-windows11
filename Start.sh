#!/bin/bash
# Permanent Victory Script - Zrok Version (Verified Free & No Card)

# 1. Install Zrok
mkdir -p bin
curl -sLO https://github.com/openziti/zrok/releases/download/v0.4.42/zrok_0.4.42_linux_amd64.tar.gz
tar -xzf zrok_0.4.42_linux_amd64.tar.gz -C bin
export PATH=$PATH:$(pwd)/bin

# 2. Setup Windows (Stable Settings)
mkdir -p /workspaces/windows-storage
sudo docker run -d --name windows \
  --device=/dev/kvm --cap-add NET_ADMIN \
  -p 8006:8006 -p 3389:3389 \
  -e VERSION="win11" -e RAM_SIZE="7G" -e DISK_SIZE="35G" \
  -e USERNAME="Docker" -e PASSWORD="admin123" \
  -v /workspaces/windows-storage:/storage \
  dockurr/windows

# 3. Start Invite
echo "📧 Type your email when asked to get your permanent link!"
zrok invite
