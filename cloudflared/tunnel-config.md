# Cloudflare Tunnel Setup Guide

Since you already have your domain (bangbangsport.top) and Cloudflare Tunnel configured, here's how to restore it on your new Pi:

## 1. Install Cloudflared

Run the installation script:
```bash
chmod +x cloudflared/install_cloudflared.sh
./cloudflared/install_cloudflared.sh
```

## 2. Restore Your Tunnel

If you have your tunnel JSON certificate file backed up:

1. Copy your existing `<tunnel-id>.json` file to the Pi
2. Place it in `~/.cloudflared/`
3. Create the config file (see step 3 below)

## 3. Create Tunnel Configuration

Create `~/.cloudflared/config.yml`:

```yaml
tunnel: <your-tunnel-id>
credentials-file: /home/kevin/.cloudflared/<tunnel-id>.json

ingress:
  - hostname: bangbangsport.top
    service: http://localhost:4533
  - hostname: "*.bangbangsport.top"
    service: http://localhost:4533
  - service: http_status:404
```

Replace `<your-tunnel-id>` and `<tunnel-id>` with your actual tunnel ID.

## 4. Install as System Service

```bash
sudo cloudflared service install
sudo systemctl enable cloudflared
sudo systemctl start cloudflared
```

## 5. Check Status

```bash
sudo systemctl status cloudflared
```

## Alternative: Create New Tunnel

If you don't have the tunnel backup:

### From your desktop/laptop:

1. **Login to Cloudflare:**
   ```bash
   cloudflared tunnel login
   ```

2. **Create tunnel:**
   ```bash
   cloudflared tunnel create navidrome
   ```

3. **Copy the generated JSON file to your Pi:**
   ```bash
   scp ~/.cloudflared/<tunnel-id>.json kevin@<pi-ip>:~/.cloudflared/
   ```

### On your Pi:

4. **Create config file** as shown in step 3 above

5. **Update DNS record** (if needed):
   ```bash
   cloudflared tunnel route dns navidrome bangbangsport.top
   ```

6. **Install as service** as shown in step 4 above

## Troubleshooting

- **Check logs:** `sudo journalctl -u cloudflared -f`
- **Test connection:** `curl -I https://bangbangsport.top`
- **Verify tunnel:** `cloudflared tunnel info navidrome`

Your music server should now be accessible at `https://bangbangsport.top`! 