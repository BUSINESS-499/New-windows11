#!/bin/bash
# Zrok Permanent Setup - No Card, No Fail (2026 Update)

# 1. Download LATEST Zrok (v1.0+)
# Automatically picks the right version to avoid "Out of Date" errors
ZROK_VERSION=$(curl -sSf https://api.github.com/repos/openziti/zrok/releases/latest | jq -r '.tag_name')
GOXARCH=amd64
curl -sSfL "https://github.com/openziti/zrok/releases/download/${ZROK_VERSION}/zrok_${ZROK_VERSION#v}_linux_${GOXARCH}.tar.gz" | tar -xz
sudo install -o root -g root ./zrok /usr/local/bin/

# 2. Start Windows 11
mkdir -p /workspaces/windows-storage
sudo docker run -d --name windows \
  --device=/dev/kvm --cap-add NET_ADMIN \
  -p 8006:8006 -p 3389:3389 \
  -e VERSION="win11" -e RAM_SIZE="7G" -e DISK_SIZE="35G" \
  -v /workspaces/windows-storage:/storage \
  dockurr/windows

# 3. Setup the New API Endpoint (Avoids 404 errors)
zrok config set apiEndpoint https://api-v1.zrok.io

# 4. Request Invite
echo "------------------------------------------------"
echo "STEP 1: Type your email below and press ENTER."
echo "------------------------------------------------"
zrok invite
