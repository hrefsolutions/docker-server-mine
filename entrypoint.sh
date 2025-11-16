#!/bin/bash
set -e

echo "=== Starting MinePanel + FileBrowser on Railway ==="

mkdir -p /app/servers
mkdir -p /app/data
mkdir -p /app/filebrowser-data

# Backend + Frontend (MinePanel arranca ambos)
minepanel --base-dir /app --port 8091 &

# FileBrowser
filebrowser -p 8080 -r /app/servers --config /app/filebrowser-data/filebrowser.json &

wait
