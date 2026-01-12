#!/bin/bash
# Victory Script - Playit.gg Version (No Credit Card, No TV Login)

# 1. Setup Storage
mkdir -p /workspaces/windows-storage

# 2. Install Playit.gg
curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./ " | sudo tee /etc/apt/sources.list.d/playit.list
sudo apt update && sudo apt install playit -y

# 3. Start Windows 11
# Disk 35G = No crash / RAM 7G = Fast
sudo docker run -d --name windows \
  --device=/dev/kvm \
  --cap-add NET_ADMIN \
  -p 8006:8006 \
  -p 3389:3389 \
  -e VERSION="win11" \
  -e RAM_SIZE="7G" \
  -e CPU_CORES="3" \
  -e DISK_SIZE="35G" \
  -e USERNAME="Docker" \
  -e PASSWORD="admin123" \
  -v /workspaces/windows-storage:/storage \
  dockurr/windows

# 4. Launch Playit
playit
