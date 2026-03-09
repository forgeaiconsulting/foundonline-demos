#!/bin/bash
# deploy.sh - Deploy a specific demo site to Netlify
# Usage: ./deploy.sh <site-name>
# Example: ./deploy.sh taylor-electric

set -e

SITE_NAME="${1:-}"
API_KEY="${GOOGLE_PLACES_KEY:-AIzaSyA6NN6Z86izW_bssd8R6ma_6XLYvBv_W2c}"

if [ -z "$SITE_NAME" ]; then
    echo "Usage: ./deploy.sh <site-name>"
    echo "Example: ./deploy.sh taylor-electric"
    echo ""
    echo "Available sites:"
    ls -1 sites/ 2>/dev/null || echo "  (none yet)"
    exit 1
fi

SITE_DIR="sites/$SITE_NAME"

if [ ! -d "$SITE_DIR" ]; then
    echo "Error: Site directory not found: $SITE_DIR"
    exit 1
fi

if [ ! -f "$SITE_DIR/index.html" ]; then
    echo "Error: index.html not found in $SITE_DIR"
    exit 1
fi

echo "=== Deploying $SITE_NAME ==="
echo "Site directory: $SITE_DIR"

# Deploy to Netlify
cd "$SITE_DIR"
netlify deploy --prod --dir . --auth "$NETLIFY_AUTH_TOKEN"

echo ""
echo "=== Deployed $SITE_NAME ==="
