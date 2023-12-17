#!/bin/bash

# Create root_cron_script.sh in the /tmp directory
echo '#!/bin/bash' > /tmp/root_cron_script.sh
echo 'echo "Current Time: $(date)"' >> /tmp/root_cron_script.sh

# Make root_cron_script.sh executable and readable/writable by anyone
chmod 777 /tmp/root_cron_script.sh

# Add a cron job entry for root to run root_cron_script.sh every minute
(crontab -l 2>/dev/null; echo "* * * * * /tmp/root_cron_script.sh") | crontab -
