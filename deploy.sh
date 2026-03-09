#!/bin/bash
# deploy.sh - Deploy a specific demo site to Netlify
# Usage: ./deploy.sh <site-name>
# Example: ./deploy.sh taylor-electric

set -e

SITE_NAME="${1:-}"
NETLIFY_TOKEN="${NETLIFY_AUTH_TOKEN:-nfp_JCjMQDTXQruKBQyvUMNFCDTwuJmwf7jX72cf}"

if [ -z "$SITE_NAME" ]; then
    echo "Usage: ./deploy.sh <site-name>"
    echo "Example: ./deploy.sh taylor-electric-ac"
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

# Check if site already exists on Netlify
EXISTING_SITE=$(curl -s -H "Authorization: Bearer $NETLIFY_TOKEN" "https://api.netlify.com/api/v1/sites" | jq -r ".[] | select(.name==\"$SITE_NAME\") | .id")

cd "$SITE_DIR"

if [ -n "$EXISTING_SITE" ]; then
    echo "Found existing Netlify site. Deploying to site ID: $EXISTING_SITE"
    netlify deploy --prod --dir . --auth "$NETLIFY_TOKEN" --site "$EXISTING_SITE"
else
    echo "Creating new Netlify site: $SITE_NAME"
    netlify deploy --prod --dir . --auth "$NETLIFY_TOKEN" --site "$SITE_NAME"
fi

echo ""
echo "=== Deployed $SITE_NAME ==="
