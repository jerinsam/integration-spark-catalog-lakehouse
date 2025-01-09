#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Start Minio Server and Console 
minio server /usr/unitycatalog/unity-catalog-dev/data --console-address ":9001" > /usr/unitycatalog/unity-catalog-dev/logs/minio.log 2>&1 &

# Keep the script running
tail -f /dev/null
