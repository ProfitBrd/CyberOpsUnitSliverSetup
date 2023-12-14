#!/bin/bash

# Script to set up SSH client and key-based authentication on Server A

echo "Setting up SSH client on Server A..."

# Update package list and install OpenSSH client
sudo apt-get update
sudo apt-get install -y openssh-client
