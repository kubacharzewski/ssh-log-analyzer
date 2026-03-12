# SSH Log Analyzer

Simple Bash script that analyzes SSH login activity from Linux system logs.

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

## Example Output

===SSH LOGIN REPORT===
Report generated: ...
Log file: /var/log/secure

Successful SSH logins:
...

Failed SSH logins:
...

===SSH LOGIN IP ADDRESSES===
...

===POTENTIAL BRUTE FORCE ATTACKS===
...

===END OF REPORT===
