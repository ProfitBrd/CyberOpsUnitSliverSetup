#!/bin/bash

# ANSI Color Codes
GREEN='\033[1;32m'
NC='\033[0m' # No Color

# Function to generate SSH key
generate_ssh_key() {
    local username=$1
    local ssh_dir="/home/$username/.ssh"
    local rsa_key="$ssh_dir/id_rsa"

    # Check if the RSA key already exists
    if [ -f "$rsa_key" ]; then
        echo -e "${GREEN}RSA key already exists. Using the existing key.${NC}"
    else
        echo -e "${GREEN}Generating an SSH key pair without a passphrase...${NC}"
        mkdir -p "$ssh_dir"
        ssh-keygen -t rsa -b 4096 -N "" -f "$rsa_key"
        chown -R $username:$username "$ssh_dir"
    fi
}

# Function to copy SSH key to target server
copy_ssh_key() {
    local username=$1
    local ip_address=$2
    local rsa_pub_key="/home/$username/.ssh/id_rsa.pub"

    # Check if ssh-copy-id exists
    if command -v ssh-copy-id &> /dev/null; then
        echo -e "${GREEN}Using ssh-copy-id to install the public key on the target server...${NC}"
        ssh-copy-id -i "$rsa_pub_key" "$username@$ip_address"
    else
        echo -e "${GREEN}ssh-copy-id could not be found. Attempting to manually install the public key.${NC}"
        local public_key=$(cat "$rsa_pub_key")
        ssh "$username@$ip_address" "mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo \"$public_key\" >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
    fi
    echo -e "${GREEN}Public key installed on the target server.${NC}"
}

# Check for root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${GREEN}This script must be run as root.${NC}"
    exit 1
fi

# Prompt for the target server's username and IP address
read -p "Enter your local username: " local_username
read -p "Enter the target server's username: " target_username
read -p "Enter the IP address of the target server: " target_ip_address

# Generate SSH key for the local user
generate_ssh_key "$local_username"

# Copy the SSH public key to the target server
copy_ssh_key "$target_username" "$target_ip_address"

echo -e "${GREEN}Setup complete.${NC}"
