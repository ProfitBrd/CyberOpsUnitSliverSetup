#!/bin/bash

# ANSI Color Codes
GREEN='\033[1;32m'
NC='\033[0m' # No Color

# Displaying the current IP address
current_ip=$(hostname -I | cut -d' ' -f1)
echo -e "${GREEN}Current IP Address of Server A: $current_ip${NC}"

# Ensure 'aeverwooddesktop' user exists with password
echo -e "${GREEN}Ensuring user 'aeverwooddesktop' exists...${NC}"
if id "aeverwooddesktop" &>/dev/null; then
    echo -e "${GREEN}User 'aeverwooddesktop' already exists.${NC}"
else
    echo -e "${GREEN}Creating user 'aeverwooddesktop'...${NC}"
    sudo useradd -m -s /bin/bash aeverwooddesktop
    echo "aeverwooddesktop:password" | sudo chpasswd
    echo -e "${GREEN}User 'aeverwooddesktop' has been created with the specified password.${NC}"
fi


# Starting setup
echo -e "${GREEN}Starting setup...${NC}"

# Step 1: Install UFW (Uncomplicated Firewall)
echo -e "${GREEN}Installing UFW (Uncomplicated Firewall)...${NC}"
sudo apt-get update
sudo apt-get install ufw -y

# Step 2: Install OpenSSH Server
echo -e "${GREEN}Installing OpenSSH Server...${NC}"
sudo apt-get install openssh-server -y

# Step 3: Check if SSH is running and start it if not
echo -e "${GREEN}Checking if SSH is running...${NC}"
ssh_status=$(systemctl is-active ssh)
if [ "$ssh_status" != "active" ]; then
    echo -e "${GREEN}SSH is not running. Starting SSH...${NC}"
    sudo systemctl start ssh
    sudo systemctl enable ssh
    echo -e "${GREEN}SSH service started.${NC}"
else
    echo -e "${GREEN}SSH is already running.${NC}"
fi
