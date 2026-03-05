#!/bin/bash
set -e

echo "🧹 Cleaning old Xvfb lock files..."
rm -rf /tmp/.X*lock /tmp/.X11-unix/* 2>/dev/null || true

echo "🚀 Starting Xvfb virtual display for Editly..."
Xvfb :99 -screen 0 1920x1080x24 -ac +extension GLX +render -noreset &
sleep 2
export DISPLAY=:99

echo "✅ Xvfb ready (DISPLAY=:99)"
echo "Starting Editly API..."

exec node server.mjs
