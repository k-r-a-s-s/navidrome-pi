#!/bin/bash
set -e

echo "🛠️ Updating system..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing dependencies..."
sudo apt install -y docker.io docker-compose git curl python3 python3-venv unzip

echo "🔧 Adding user to docker group..."
sudo usermod -aG docker $USER

echo "🔁 Setting up mount point for external SSD..."
sudo mkdir -p /mnt/musicdrive/music /mnt/musicdrive/navidrome-data
sudo chown -R $USER:$USER /mnt/musicdrive

echo "🐳 Setting up Navidrome..."
mkdir -p ~/navidrome
cp docker-compose.yml ~/navidrome/
cd ~/navidrome

echo "🚀 Starting Navidrome..."
docker-compose up -d

echo "✅ Navidrome started! Visit http://$(hostname -I | awk '{print $1}'):4533"
echo "📂 Music folder: /mnt/musicdrive/music"
echo "📊 Data folder: /mnt/musicdrive/navidrome-data"
echo ""
echo "Next steps:"
echo "1. Mount your external SSD to /mnt/musicdrive (if not already done)"
echo "2. Run 'beets/install_beets.sh' to set up music management"
echo "3. Run 'cloudflared/install_cloudflared.sh' to set up remote access"
echo ""
echo "⚠️  You may need to logout and login again for docker group changes to take effect." 