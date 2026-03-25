#!/bin/bash

LOG_FILE="/var/log/secure"
TOP_LIMIT=5
BRUTE_FORCE_THRESHOLD=5

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
NC="\e[0m"

if [ ! -f "$LOG_FILE" ]; then
	echo "Log file not found: $LOG_FILE"
	exit 1
fi

echo ""
echo "============================================================"
echo "SSH log analyzer report $(date)"
echo "============================================================"
echo "Log file: $LOG_FILE"
echo ""

SUCCESS_COUNT=$(grep "sshd.*Accepted password" "$LOG_FILE" | wc -l)

echo "===Successful SSH logins==="
echo "Successful SSH logins: $SUCCESS_COUNT"

if [ "$SUCCESS_COUNT" -gt 0 ]; then
   echo -e "${GREEN}OK: Successful logins detected${NC}"
else
   echo -e "${YELLOW}INFO: No successful SSH logins found${NC}"
fi
echo ""

FAILED_COUNT=$(grep "sshd.*Failed password" "$LOG_FILE" | wc -l)

echo "===Failed SSH logins==="
echo "Failed SSH logins: $FAILED_COUNT"

if [ "$FAILED_COUNT" -gt 0 ]; then
   echo -e  "${RED}WARNING: Failed SSH login attempts detected${NC}"
else
   echo -e "${GREEN}OK: No failed SSH logins found${NC}"
fi


echo ""
echo "===Successful SSH login IP adresses==="
grep "sshd.*Accepted password for" "$LOG_FILE" \
| awk '{for(i=1;i<=NF;i++) if($i ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/) print $i}' \
| sort \
| uniq -c \
| sort -nr
echo ""

echo "===Potential brute force sources==="
grep "sshd.*Failed password for" "$LOG_FILE" \
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
