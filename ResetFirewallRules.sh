#!/bin/bash

# This script is used if you mess up a server setup script and want to reset the firewall rules to try again

# ANSI Color Codes
GREEN='\033[1;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Resetting UFW (Uncomplicated Firewall) to default settings...${NC}"

# Reset UFW to default settings
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw --force reset

echo -e "${GREEN}UFW has been reset to its default state.${NC}"
