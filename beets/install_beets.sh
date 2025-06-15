#!/bin/bash
set -e

echo "🐍 Creating Python virtual environment for Beets..."
python3 -m venv ~/beets-venv

echo "📦 Installing Beets and dependencies..."
source ~/beets-venv/bin/activate
pip install --upgrade pip
pip install beets requests

echo "📁 Setting up Beets configuration directory..."
mkdir -p ~/.config/beets

echo "⚙️ Copying Beets configuration..."
cp "$(dirname "$0")/config.yaml" ~/.config/beets/config.yaml

echo "📂 Creating music directories..."
mkdir -p /mnt/musicdrive/Music/Inbox
mkdir -p /mnt/musicdrive/Music/Unmatched

echo "✅ Beets installed and configured!"
echo ""
echo "To use Beets:"
echo "1. Activate the virtual environment: source ~/beets-venv/bin/activate"
echo "2. Import music: beet import /path/to/music"
echo "3. Drop new music in: /mnt/musicdrive/Music/Inbox"
echo ""
echo "Configuration file: ~/.config/beets/config.yaml" 