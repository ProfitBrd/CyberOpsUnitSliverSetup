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

# Step 4: Get IP of Server A
# Ask for the IP address of Server A
read -p "Enter Server A's IP address: " server_a_ip

# Validate the IP address format (basic regex, not perfect validation)
if [[ $server_a_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Configuring UFW to allow all traffic from $server_a_ip ..."

    # Allow all traffic from Server A's IP
    sudo ufw allow from $server_a_ip

    # Enable UFW
    sudo ufw enable

    echo "Firewall updated successfully."
else
    echo "Invalid IP address format."
    exit 1
fi
