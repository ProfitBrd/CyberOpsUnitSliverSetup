#!/bin/bash

# Bash script to install necessary components, reset firewall rules, 
# and allow all connections from a specific IP on Server B

echo "Starting setup..."

# Step 1: Install UFW
echo "Installing UFW (Uncomplicated Firewall)..."
sudo apt update
sudo apt install ufw -y

# Step 2: Install OpenSSH Server
echo "Installing OpenSSH Server..."
sudo apt install openssh-server -y

# Step 3: Configure UFW
echo "Configuring firewall..."

# Reset UFW to default settings
echo "Resetting UFW to default settings..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw --force reset
