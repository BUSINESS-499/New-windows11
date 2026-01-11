#!/bin/bash
# Create storage
mkdir -p /workspaces/windows-storage

# Run Windows 11 with MAX 8GB RAM
# Includes 'virtio-balloon' to help memory management
sudo docker run -it --rm --name windows \
  --device=/dev/kvm \
  --cap-add NET_ADMIN \
  -p 8006:8006 \
  -p 3389:3389 \
  -e VERSION="win11" \
  -e RAM_SIZE="8G" \
  -e CPU_CORES="4" \
  -e DISK_SIZE="64G" \
  -e USERNAME="Docker" \
  -e PASSWORD="admin123" \
  -e ARGUMENTS="-device virtio-balloon" \
  -v /workspaces/windows-storage:/storage \
  dockurr/windows
