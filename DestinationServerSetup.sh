#!/bin/bash

# Bash script to reset firewall rules and allow all connections from a specific IP on Server B

echo "Starting firewall configuration..."

# Reset UFW to default settings
echo "Resetting UFW to default settings..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw --force reset

# Ask for the IP address of Server A
read -p "Enter Server A's IP address: " server_a_ip

# Validate the IP address format (basic regex, not perfect validation)
if [[ $server_a_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Configuring UFW to allow all traffic from $server_a_ip ..."

    # Allow all traffic from Server A's IP
    sudo ufw allow from $server_a_ip

    # Enable UFW if it's not already enabled
    sudo ufw enable

    echo "Firewall updated successfully."
else
    echo "Invalid IP address format."
    exit 1
fi
