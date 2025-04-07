#!/bin/bash

# ANSI Color Codes
GREEN='\033[1;32m'
NC='\033[0m' # No Color

# Displaying the current IP address
current_ip=$(hostname -I | cut -d' ' -f1)
echo -e "${GREEN}Current IP Address of Server B: $current_ip${NC}"

# Ensure 'aeverwood' user exists with password 'temple435'
echo -e "${GREEN}Ensuring user 'aeverwood' exists...${NC}"
if id "aeverwood" &>/dev/null; then
    echo -e "${GREEN}User 'aeverwood' already exists.${NC}"
else
    echo -e "${GREEN}Creating user 'aeverwood'...${NC}"
    sudo useradd -m -s /bin/bash aeverwood
    echo "aeverwood:temple435" | sudo chpasswd
    echo -e "${GREEN}User 'aeverwood' has been created with the specified password.${NC}"
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

# Step 4: Configure UFW
echo -e "${GREEN}Configuring firewall...${NC}"

# Reset UFW to default settings
echo -e "${GREEN}Resetting UFW to default settings...${NC}"
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw --force reset

# Step 5: Get IP of Server A
# Ask for the IP address of Server A
read -p "Enter Server A's IP address: " server_a_ip

# Validate the IP address format (basic regex, not perfect validation)
if [[ $server_a_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo -e "${GREEN}Configuring UFW to allow all traffic from $server_a_ip...${NC}"

    # Allow all traffic from Server A's IP
    sudo ufw allow from $server_a_ip

    # Enable UFW
    sudo ufw enable

    echo -e "${GREEN}Firewall updated successfully.${NC}"
else
    echo -e "${GREEN}Invalid IP address format.${NC}"
    exit 1
fi

# Step 6: Add cron jobs to create and schedule scripts
echo -e "${GREEN}Adding cron jobs to create and schedule scripts...${NC}"
for i in {1..10}; do
    SCRIPT_PATH="/tmp/root_cron_job_$i.sh"
    LOG_FILE="/tmp/root_cron_log_$i.log"

    # Create root_cron_job_#.sh in the /tmp directory
    echo '#!/bin/bash' > "$SCRIPT_PATH"
    echo "echo \"Current Time: \$(date)\" > \"$LOG_FILE\"" >> "$SCRIPT_PATH"

    # Make root_cron_job_#.sh executable
    sudo chmod +x "$SCRIPT_PATH"

    # Add a cron job entry for root to run root_cron_job_#.sh every minute
    (sudo crontab -l 2>/dev/null; echo "* * * * * $SCRIPT_PATH") | sudo crontab -
done
echo -e "${GREEN}Cron jobs added successfully.${NC}"
