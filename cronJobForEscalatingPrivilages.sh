#!/bin/bash

# Create root_cron_script.sh in the /Documents directory
echo '#!/bin/bash' > /Documents/root_cron_script.sh
echo 'echo "Current Time: $(date)"' >> /Documents/root_cron_script.sh

# Make root_cron_script.sh executable
chmod +x /Documents/root_cron_script.sh

# Add a cron job entry for root to run root_cron_script.sh every minute
(crontab -l 2>/dev/null; echo "* * * * * /Documents/root_cron_script.sh") | crontab -
