#!/bin/bash
# Serveo RDP Tunnel - With Cores, User, and Pass

# 1. Setup Storage
mkdir -p /workspaces/windows-storage

# 2. Start Windows 11 with your specific settings
# RAM: 7GB | Cores: 3 | User: Docker | Pass: admin123
sudo docker run -d --name windows \
  --device=/dev/kvm --cap-add NET_ADMIN \
  -p 8006:8006 -p 3389:3389 \
  -e VERSION="win11" \
  -e RAM_SIZE="7G" \
  -e CPU_CORES="3" \
  -e USERNAME="Docker" \
  -e PASSWORD="admin123" \
  -v /workspaces/windows-storage:/storage \
  dockurr/windows

# 3. Start the Tunnel
echo "------------------------------------------------"
echo "Connecting to Serveo..."
echo "If it asks (yes/no), type 'yes' and hit Enter."
echo "------------------------------------------------"
ssh -o ServerAliveInterval=60 -R 80:localhost:3389 serveo.net
