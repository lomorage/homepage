#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"
npm ci
npm test
npm run build
echo "Static site is ready in dist/. GitHub Actions publishes it when changes are pushed to master."
