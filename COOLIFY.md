# Deploy Clawdbot on Coolify - Step by Step

## Prerequisites

- A Coolify instance running
- An Anthropic API key ([Get it here](https://console.anthropic.com/))

## Deployment Steps

### 1. Create New Resource in Coolify

1. Go to your Coolify dashboard
2. Click **Projects** in the sidebar
3. Select your project (or create a new one)
4. Click **+ New** → **Public Repository**

### 2. Configure Repository

- **Repository URL**: `https://github.com/beez2thawax/clawdbotdocker`
- **Branch**: `main`
- Click **Continue**

### 3. Select Build Pack

- Coolify should auto-detect **Docker Compose**
- If not, manually select **Docker Compose**
- Click **Continue**

### 4. Configure Environment Variables

**REQUIRED - You must set this:**

Click on **Environment Variables** tab and add:

```
ANTHROPIC_API_KEY=sk-ant-your-api-key-here
```

**OPTIONAL:**

```
TELEGRAM_BOT_TOKEN=your-telegram-bot-token
GATEWAY_TOKEN=your-custom-secure-token
```

If you don't set `GATEWAY_TOKEN`, it will default to `please-change-this-token`

### 5. Configure Ports (Important!)

In the **Ports** section, make sure these are exposed:

- **18789** - Main dashboard and WebSocket gateway
- **18791** - Browser control (optional)

Coolify should map these automatically from the docker-compose file.

### 6. Configure Domain

**IMPORTANT:** You must set a domain for Coolify's proxy to route traffic:

1. Go to the **Domains** tab in your application
2. Click **Add Domain**
3. Enter your domain (e.g., `clawdbot.yourdomain.com`)
4. Coolify will automatically set up SSL with Let's Encrypt

### 7. Deploy

1. Click **Save**
2. Click **Deploy**
3. Wait for the build to complete (5-10 minutes first time)

### 8. Access Your Dashboard

Once deployed, Coolify will provide a URL. Access your dashboard at:

```
https://your-generated-domain.sslip.io/?token=please-change-this-token
```

Or if you set a custom domain:
```
https://clawdbot.yourdomain.com/?token=please-change-this-token
```

No port number needed - Coolify handles everything automatically!

### 9. Connect the Dashboard

1. Open the dashboard URL
2. In the **WebSocket URL** field, enter: `wss://your-domain` (same as dashboard URL, no port)
3. In the **Gateway Token** field, enter your token (default: `please-change-this-token`)
4. Click **Connect**

## Troubleshooting

### Container keeps restarting
- Check that `ANTHROPIC_API_KEY` is set correctly
- View logs in Coolify: click on your app → **Logs** tab

### Dashboard won't connect
- Make sure port 18789 is accessible
- Try using `wss://` instead of `ws://` for the WebSocket URL
- Check that the token matches exactly

### Can't access the dashboard
- Verify port 18789 is exposed in Coolify
- Check container logs for errors
- Make sure the container is running

## Next Steps

Once connected:

1. **Configure Telegram** (if you set `TELEGRAM_BOT_TOKEN`):
   - Go to **Channels** in the dashboard
   - Enable Telegram
   - Message your bot on Telegram

2. **Connect WhatsApp**:
   - Go to **Channels** → **WhatsApp**
   - Scan QR code with WhatsApp

3. **Start Chatting**:
   - Message your bot on any connected platform
   - It will respond using Claude AI

## Need Help?

- [Clawdbot Documentation](https://docs.molt.bot/)
- [Coolify Documentation](https://coolify.io/docs)
- [GitHub Issues](https://github.com/beez2thawax/clawdbotdocker/issues)
