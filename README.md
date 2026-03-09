# FoundOnline Demos

Monorepo for demo websites built for FoundOnline.pro prospects.

## Structure

```
foundonline-demos/
├── sites/                    # Individual demo sites
│   ├── taylor-electric/      # Example: taylor-electric-ac-demo
│   │   └── index.html
│   └── [business-name]/      # One folder per prospect
│       └── index.html
├── deploy.sh                 # Deploy script
└── README.md                 # This file
```

## Adding a New Demo

1. Create a new folder in `sites/` with a slug version of the business name:
   ```bash
   mkdir sites/nguyen-brothers-plumbing
   ```

2. Add your `index.html` and any assets to the folder.

3. Deploy:
   ```bash
   ./deploy.sh nguyen-brothers-plumbing
   ```

## Deploying

Each site deploys as a separate Netlify site:

```bash
# Deploy a specific site
./deploy.sh <site-name>

# Example
./deploy.sh taylor-electric
```

## Requirements

- Netlify CLI installed
- `NETLIFY_AUTH_TOKEN` set in environment
- GitHub access to this repo

## Current Sites

| Site | Business | Status |
|------|----------|--------|
| taylor-electric | Taylor Electric AC | Live |

## Notes

- Each site is a single-page HTML demo
- Tailwind CSS via CDN (no build step)
- Mobile-first, modern design
- Real business info, placeholder images
