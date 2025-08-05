#!/bin/bash

# Debug information
echo "Starting osTicket on Railway..."
echo "PHP version: $(php -v | head -n 1)"
echo "Current directory: $(pwd)"
echo "Files in current directory:"
ls -la

# Check if required files exist
if [ ! -f "index.php" ]; then
    echo "ERROR: index.php not found!"
    exit 1
fi

if [ ! -f "include/ost-config.php" ]; then
    echo "WARNING: ost-config.php not found - this is normal for first deployment"
fi

# Start PHP server
echo "Starting PHP server on port $PORT..."
php -S 0.0.0.0:$PORT -t . 