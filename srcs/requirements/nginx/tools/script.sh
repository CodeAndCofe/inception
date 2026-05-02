#!/bin/bash
set -e

echo "Starting Nginx..."

nginx -t

exec "$@"