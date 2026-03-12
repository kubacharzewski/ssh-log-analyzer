#!/bin/bash

LOGFILE="/var/log/secure"

if [ ! -f "$LOGFILE" ]; then
	echo "Log file not found: $LOGFILE"
	exit 1
fi

echo "===SSH LOGIN REPORT=="
echo "Report generated: $(date)"
echo "Log file: $LOGFILE"
echo ""

echo "Successful SSH logins:"
sudo grep "sshd.*Accepted password" "$LOGFILE" | wc -l

echo ""
echo "Failed SSH logins:"
sudo grep "sshd.*Failed password" "$LOGFILE" | wc -l

echo ""
echo "===SSH LOGIN IP ADDRESSES==="
sudo grep "sshd.*Accepted password for" "$LOGFILE" | awk '{for(i=1;i<=NF;i++) if($i ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/) print $i}' | 
sort | uniq -c | sort -nr

echo ""
echo "===POTENTIAL BRUTE FORCE ATTACKS==="
sudo grep "sshd.*Failed password for" "$LOGFILE" | awk '{for(i=1;i<=NF;i++) if($i ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/) print $i}' | 
sort | uniq -c | sort -nr | head -5

echo ""
echo "===END OF RAPORT==="
