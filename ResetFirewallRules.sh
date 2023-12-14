#!/bin/bash

# Reset UFW to default settings
echo "Resetting UFW to default settings..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw --force reset
