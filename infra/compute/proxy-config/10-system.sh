#!/usr/bin/env bash
set -euo pipefail

# Update the system
sudo dnf update -y

# Creates a swapfile
if [ ! -f /swapfile ]; then
  sudo dd if=/dev/zero of=/swapfile bs=128M count=32
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile
fi

if ! sudo swapon --show=NAME | grep -q '^/swapfile$'; then
  sudo swapon /swapfile
fi

if ! grep -q '^/swapfile ' /etc/fstab; then
  echo "/swapfile swap swap defaults 0 0" | sudo tee -a /etc/fstab
fi

# Install Java
sudo dnf install -y java-21-amazon-corretto-headless wget screen acl awscli
