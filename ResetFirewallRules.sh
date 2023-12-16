#!/bin/bash

# ANSI Color Codes
GREEN='\033[1;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Resetting UFW (Uncomplicated Firewall) to default settings...${NC}"

# Reset UFW to default settings
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw --force reset

echo -e "${GREEN}UFW has been reset to its default state.${NC}"
