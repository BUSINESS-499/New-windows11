#!/bin/bash
# Victory Script - Ngrok Version (No Tailscale needed)

# 1. Setup Storage
mkdir -p /workspaces/windows-storage

# 2. Install Ngrok (This is the magic part)
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok

# 3. Connect Ngrok (REPLACE 'YOUR_TOKEN_HERE' WITH YOUR ACTUAL TOKEN)
ngrok config add-authtoken 2tE4GHJOdRn1RyMU1z4I3UTtvnw_2TSVVi8Lh9SxqTabudR4k
ngrok tcp 3389 &

# 4. Run Windows 11
sudo docker run -it --rm --name windows \
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
