#!/bin/bash
set -e

echo "☁️ Installing Cloudflare Tunnel..."

# Download the ARM64 version for Raspberry Pi
echo "📥 Downloading cloudflared for ARM64..."
wget -O cloudflared-linux-arm64.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64.deb

echo "📦 Installing cloudflared..."
sudo dpkg -i cloudflared-linux-arm64.deb

echo "🗑️ Cleaning up download..."
rm cloudflared-linux-arm64.deb

echo "✅ Cloudflared installed successfully!"
echo ""
echo "Next steps:"
echo "1. Create tunnel from your desktop: cloudflared tunnel login && cloudflared tunnel create navidrome"
echo "2. Copy the generated cert.json to your Pi"
echo "3. Create config file: ~/.cloudflared/config.yml"
echo "4. Install as service: cloudflared service install"
echo ""
echo "See tunnel-config.md for detailed setup instructions." 