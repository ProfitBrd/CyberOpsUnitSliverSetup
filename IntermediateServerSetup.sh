#!/bin/bash

# Bash script to install necessary components, reset firewall rules, 
# and configure SSH on Server A (Intermediary Server)

echo "Starting setup..."

# Step 1: Install UFW (Uncomplicated Firewall)
echo "Installing UFW..."
sudo apt update
sudo apt install ufw -y

# Step 2: Install OpenSSH Server
echo "Installing OpenSSH Server..."
sudo apt install openssh-server -y

# Step 3: Check if SSH is running and start it if not
echo "Checking if SSH is running..."
ssh_status=$(systemctl is-active ssh)
if [ "$ssh_status" != "active" ]; then
    echo "SSH is not running. Starting SSH..."
    sudo systemctl start ssh
    sudo systemctl enable ssh
    echo "SSH service started."
else
    echo "SSH is already running."
fi

# Step 4: Configure UFW
echo "Configuring firewall..."

# Reset UFW to default settings
echo "Resetting UFW to default settings..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw --force reset

# Note: Further firewall configuration may be needed based on your specific requirements.
