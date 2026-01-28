#!/bin/bash
set -e

CONFIG_FILE="/root/.clawdbot/clawdbot.json"

# Copy base config if it doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
  cp /app/config.json "$CONFIG_FILE"
fi

# Replace token in config if GATEWAY_TOKEN is set
if [ ! -z "$GATEWAY_TOKEN" ]; then
  sed -i "s/CHANGE_THIS_TOKEN_TO_SECURE_VALUE/$GATEWAY_TOKEN/g" "$CONFIG_FILE"
fi

# Update port to 18789 for Coolify with explicit port in domain
jq '.gateway.port = 18789' "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"

# Update Telegram config if token is provided
if [ ! -z "$TELEGRAM_BOT_TOKEN" ]; then
  # Enable telegram plugin and channel
  cat "$CONFIG_FILE" | jq \
    '.plugins.entries.telegram.enabled = true |
     .channels.telegram.enabled = true |
     .channels.telegram.botToken = env.TELEGRAM_BOT_TOKEN' > "$CONFIG_FILE.tmp"
  mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
fi

# Set Anthropic API key if provided
if [ ! -z "$ANTHROPIC_API_KEY" ]; then
  export ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY"
fi

# Start clawdbot on port 18789 (Coolify with explicit port in domain)
exec clawdbot gateway --port 18789
