#!/bin/bash

TOP_LIMIT=5
BRUTE_FORCE_THRESHOLD=5

if [ -f "/var/log/secure" ]; then
   LOG_FILE="/var/log/secure"
elif [ -f "/var/log/auth.log" ]; then
   LOG_FILE="/var/log/auth.log"
else
   echo "No valid log file found"
   exit 1
fi

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
NC="\e[0m"

echo ""
echo "============================================================"
echo "SSH log analyzer report $(date)"
echo "============================================================"
echo "Log file: $LOG_FILE"
echo ""

SUCCESS_COUNT=$(grep "Accepted password" "$LOG_FILE" | wc -l)

echo "===Successful SSH logins==="
echo "Successful SSH logins: $SUCCESS_COUNT"

if [ "$SUCCESS_COUNT" -gt 0 ]; then
   echo -e "${GREEN}OK: Successful logins detected${NC}"
else
   echo -e "${YELLOW}INFO: No successful SSH logins found${NC}"
fi
echo ""

FAILED_COUNT=$(grep "Failed password" "$LOG_FILE" | wc -l)

echo "===Failed SSH logins==="
echo "Failed SSH logins: $FAILED_COUNT"

if [ "$FAILED_COUNT" -gt 0 ]; then
   echo -e  "${RED}WARNING: Failed SSH login attempts detected${NC}"
else
   echo -e "${GREEN}OK: No failed SSH logins found${NC}"
fi

echo ""
echo "===Successful SSH login IP adresses==="
grep "Accepted password for" "$LOG_FILE" \
| awk '{for(i=1;i<=NF;i++) if($i ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/) print $i}' \
| sort \
| uniq -c \
| sort -nr
echo ""

echo "===Potential brute force sources==="
grep "Failed password for" "$LOG_FILE" \
| awk '{for(i=1;i<=NF;i++) if($i ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/) print $i}' \
| sort \
| uniq -c \
| awk -v threshold="$BRUTE_FORCE_THRESHOLD" '$1 >= threshold' \
| sort -nr \
| head -"$TOP_LIMIT"
echo ""
echo "============================================================"
echo "===END OF RAPORT==="
echo "============================================================"
