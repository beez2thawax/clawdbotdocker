# Clawdbot Docker Setup for Coolify

One-click Docker deployment for [Clawdbot](https://github.com/moltbot/moltbot) - your personal AI assistant that integrates with WhatsApp, Telegram, Discord, Slack, and more.

## Features

- 🚀 Easy deployment on Coolify
- 🔒 Secure token-based authentication
- 🤖 Support for Telegram, WhatsApp, Discord, Slack, and more
- 💬 Powered by Claude AI (Anthropic)
- 🌐 Web-based control dashboard
- 📦 Persistent storage for conversations and settings

## Quick Start with Coolify

### 1. Deploy on Coolify

1. Go to your Coolify dashboard
2. Click **+ New Resource** → **Docker Compose**
3. Connect this GitHub repository
4. Coolify will automatically detect the `docker-compose.yml`

### 2. Configure Environment Variables

In Coolify, add these environment variables:

**Required:**
- `ANTHROPIC_API_KEY` - Your Anthropic API key ([Get it here](https://console.anthropic.com/))

**Optional:**
- `TELEGRAM_BOT_TOKEN` - Your Telegram bot token ([Create bot via @BotFather](https://t.me/BotFather))
- `GATEWAY_TOKEN` - Custom security token (auto-generated if not set)

### 3. Configure Domain

In Coolify, you need to set a domain for your application:

1. Go to the **Domains** section
2. Add your domain (e.g., `clawdbot.yourdomain.com`)
3. Coolify will automatically handle SSL with Let's Encrypt

### 4. Access the Dashboard

After deployment:
- Dashboard URL: `https://your-generated-domain/?token=YOUR_GATEWAY_TOKEN`
- No port number needed - Coolify handles routing automatically
- Replace `YOUR_GATEWAY_TOKEN` with your actual token (default: `please-change-this-token`)

## Manual Docker Deployment

If you're not using Coolify:

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/clawdbot-docker.git
cd clawdbot-docker

# Copy and configure environment variables
cp .env.example .env
nano .env  # Add your API keys

# Start the container
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the container
docker-compose down
```

## Configuration

### Getting Your API Keys

#### Anthropic API Key (Required)
1. Visit [Anthropic Console](https://console.anthropic.com/)
2. Sign up or log in
3. Navigate to API Keys
4. Create a new key
5. Copy and add to `ANTHROPIC_API_KEY`

#### Telegram Bot Token (Optional)
1. Open Telegram and search for [@BotFather](https://t.me/BotFather)
2. Send `/newbot` and follow instructions
3. Copy the bot token
4. Add to `TELEGRAM_BOT_TOKEN`

### Ports

- `18789` - Main gateway + dashboard (WebSocket + HTTP)
- `18791` - Browser control interface

### Volumes

- `clawdbot-data` - Stores configuration and sessions
- `workspace-data` - Agent workspace files

## Usage

### Access the Dashboard

1. Open `https://your-app-url:18789/?token=YOUR_TOKEN`
2. Connect to the gateway
3. Configure channels and start chatting

### Connect Telegram

1. Set `TELEGRAM_BOT_TOKEN` in environment variables
2. Restart the container
3. Message your bot on Telegram

### Connect Other Channels

Use the dashboard to configure:
- WhatsApp (via QR code scan)
- Discord (bot token)
- Slack (bot token)
- Signal, iMessage, etc.

## Troubleshooting

### Dashboard won't connect
- Check that port 18789 is accessible
- Verify `GATEWAY_TOKEN` matches the token in the URL
- Check container logs: `docker-compose logs -f`

### Telegram not working
- Verify `TELEGRAM_BOT_TOKEN` is correct
- Check bot is not blocked
- View logs for connection status

### Gateway not starting
- Ensure `ANTHROPIC_API_KEY` is valid
- Check container logs for errors
- Verify ports are not in use

## Security Notes

- Change `GATEWAY_TOKEN` to a secure random value
- Keep your API keys private
- Use HTTPS in production (Coolify handles this automatically)
- Dashboard is protected by token authentication

## Support

- [Clawdbot Documentation](https://docs.molt.bot/)
- [GitHub Issues](https://github.com/moltbot/moltbot/issues)
- [Anthropic Documentation](https://docs.anthropic.com/)

## License

This Docker setup is provided as-is. Clawdbot itself is subject to its own license terms.
