# SSH Log Analyzer

This is a simple bash script that analyzes SSH authentication logs to detect login activity and potential security threats such as brute force attacks.

## Features

- Count successful SSH logins
- Count failed SSH logins
- Display IP addresses used for successful SSH logins
- Detect potential brute force attacks
- Verify if the log file exist
- Display report generation date

## Requirements

- Linux system
- Bash
- Access to /var/log/secure
- sudo privileges

## Usage

Make the script executable:
chmod +x analyze_logs.sh

## Run the script

sudo ./analyze_logs.sh

## Example Output

SSH log analyzer report: Wed Mar 26 00:20:04 CET

Log file: /var/log/secure

=== Successful SSH logins ===
Successful SSH logins: 3
OK: Successful logins detected

=== Failed SSH logins ===
Failed SSH logins: 12
WARNING: Failed SSH login attempts detected

=== Successful SSH login IP addresses ===
192.168.1.10
10.0.0.5

=== Potential brute force sources ===
203.0.113.45 (10 attempts)
198.51.100.22 (7 attempts)

=== END OF REPORT ===

===END OF REPORT===

## What this project demonstrates

- Bash scripting and automation
- Log parsing using grep, awk, sort, uniq
- Basic security analysis (SSH logs)
- Error handling and input validation
- Working with Linux system logs
