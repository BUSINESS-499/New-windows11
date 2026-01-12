#!/bin/bash
# Victory Script - Pinggy Version (No Card, No TV Login)

# 1. Setup Storage
mkdir -p /workspaces/windows-storage

# 2. Start Windows 11 in the background
# Using 35G to prevent crashing
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

# 3. Create the Tunnel (This provides your TV connection)
echo "🚀 Creating your TV connection... Please wait."
sleep 10
ssh -p 443 -R0:localhost:3389 a.pinggy.io
