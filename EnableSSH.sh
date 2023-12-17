#!/bin/bash

# ANSI Color Codes
GREEN='\033[1;32m'
NC='\033[0m' # No Color

# Check for root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${GREEN}This script must be run as root.${NC}"
    exit 1
fi

# Prompt for the target server's username and IP address
read -p "Enter the username for the target server: " username
read -p "Enter the IP address of the target server: " ip_address

# Check if an RSA key already exists
if [ ! -f "/home/$username/.ssh/id_rsa" ]; then
    echo -e "${GREEN}Generating an SSH key pair without a passphrase...${NC}"
    ssh-keygen -t rsa -b 4096 -N "" -f "/home/$username/.ssh/id_rsa"
else
    echo -e "${GREEN}RSA key already exists. Using the existing key.${NC}"
fi

# Install the public key on the target server
if ! command -v ssh-copy-id &> /dev/null; then
    echo -e "${GREEN}ssh-copy-id could not be found. Attempting to manually install the public key.${NC}"
    
    # Retrieve the public key
    public_key=$(cat "/home/$username/.ssh/id_rsa.pub")

    # Install the public key on the target server's authorized_keys, manually
    ssh "$username@$ip_address" "mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo $public_key >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"

    echo -e "${GREEN}Public key installed manually on the target server.${NC}"
else
    echo -e "${GREEN}Using ssh-copy-id to install the public key on the target server...${NC}"
    ssh-copy-id -i "/home/$username/.ssh/id_rsa.pub" "$username@$ip_address"
    echo -e "${GREEN}Public key installed on the target server using ssh-copy-id.${NC}"
fi

# Disable password authentication on the target server (optional)
ssh "$username@$ip_address" "sudo sed -i '/^#PasswordAuthentication yes/c\PasswordAuthentication no' /etc/ssh/sshd_config && sudo systemctl restart sshd"

echo -e "${GREEN}Password authentication disabled on the target server.${NC}"
