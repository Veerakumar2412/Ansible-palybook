#!/bin/bash
#set -x  
LOG_FILE="/var/log/apache2/access.log"
DDOS_THRESHOLD=3
CURRENT_DATE=$(date +"%d/%b/%Y")

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

# Get logs for the current date
filtered_logs=$(grep "$CURRENT_DATE" "$LOG_FILE")

# Find repeated IPs and their counts
repeated_ips=$(echo "$filtered_logs" | awk '{print $1}' | sort | uniq -c | sort -nr | awk -v threshold="$DDOS_THRESHOLD" '$1 >= threshold')

if [ -z "$repeated_ips" ]; then
    echo "No IPs exceeded the threshold for today. No repeated IPs detected."
else
    echo "Repeated IPs for $CURRENT_DATE (appeared $DDOS_THRESHOLD or more times):"
    echo "$repeated_ips" | while read -r count ip; do
        echo "$ip (appeared $count times)"
    done
fi

# Find repeated domains
echo "Repeated domains:"
grep -oP 'https?://\K[^/]+' "$LOG_FILE" | sort | uniq -c | sort -nr
