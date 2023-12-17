#!/bin/bash

SCRIPT_PATH="/tmp/root_cron_script.sh"
LOG_FILE="/tmp/root_cron_log.log"

# Create root_cron_script.sh in the /tmp directory
echo '#!/bin/bash' > "$SCRIPT_PATH"
echo "echo \"Current Time: \$(date)\" >> \"$LOG_FILE\"" >> "$SCRIPT_PATH"

# Make root_cron_script.sh executable
chmod +x "$SCRIPT_PATH"

# Add a cron job entry for root to run root_cron_script.sh every minute
(sudo crontab -l 2>/dev/null; echo "* * * * * $SCRIPT_PATH") | sudo crontab -
