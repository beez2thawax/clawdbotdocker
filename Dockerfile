FROM node:24-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Install clawdbot globally
RUN npm install -g clawdbot@latest

# Create app directory
WORKDIR /app

# Create config directory
RUN mkdir -p /root/.clawdbot

# Copy configuration files
COPY config.json /app/config.json
COPY entrypoint.sh /app/entrypoint.sh

# Make entrypoint executable
RUN chmod +x /app/entrypoint.sh

# Expose ports
EXPOSE 18789 18791

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD clawdbot health || exit 1

# Start the gateway
ENTRYPOINT ["/app/entrypoint.sh"]
