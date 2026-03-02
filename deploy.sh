#!/bin/bash
set -e

APP_DIR="/opt/ev_assist"
LOG_FILE="/var/log/ev_assist_deploy.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "Starting ev_assist deployment..."

cd "$APP_DIR"

# Fetch latest changes
log "Fetching from GitHub..."
git fetch origin main

# Check if there are new commits
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)

if [ "$LOCAL" = "$REMOTE" ]; then
    log "No updates available. Skipping deployment."
    exit 0
fi

log "New version detected. Updating..."
log "Current: $LOCAL"
log "New: $REMOTE"

# Pull changes
git pull origin main

# Install dependencies (if package.json changed)
log "Installing dependencies..."
npm install --silent

# Build application
log "Building application..."
npm run build

log "Deployment completed successfully!"
log "New version: $(git rev-parse --short HEAD)"
