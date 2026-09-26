# Task 2 — Basic Firewall Configuration with UFW

## Intern
Mahmoud Khaled

## Track
Security Analyst

## Objective
The objective of this task is to configure a basic Linux host firewall using UFW, apply allow and deny rules, verify the active firewall policy, and test that denied traffic is blocked.

## Authorized Scope
Environment: Local Kali Linux VM

Only the local VM firewall was configured and tested. No public, company, third-party, or production system was modified.

## Tools Used
- Kali Linux 2026.3
- UFW
- Python HTTP server
- Windows PowerShell
- Linux terminal

## What is a Firewall?
A firewall is a security control that filters network traffic based on rules. It can allow trusted traffic and block unwanted or risky traffic.

A host firewall such as UFW protects an individual Linux machine by controlling inbound and outbound connections.

## What is UFW?
UFW stands for Uncomplicated Firewall. It is a simpler interface for managing Linux firewall rules.

Instead of writing complex low-level firewall rules manually, UFW allows simple rules such as allow SSH, deny HTTP, allow HTTPS, and deny specific ports.

## Firewall Rules Applied

| Rule | Action | Reason |
|---|---|---|
| Default incoming | Deny | Blocks unsolicited inbound connections by default. |
| Default outgoing | Allow | Allows the VM to make normal outbound connections. |
| SSH / 22/tcp | Allow | Prevents remote administration lockout if SSH is used. |
| HTTP / 80/tcp | Deny | Demonstrates blocking inbound web traffic. |
| HTTPS / 443 | Allow | Allows secure web traffic as an additional rule. |
| Telnet / 23/tcp | Deny | Blocks an insecure legacy remote-access protocol. |

## Commands Used

- sudo ufw --force reset
- sudo ufw default deny incoming
- sudo ufw default allow outgoing
- sudo ufw allow ssh
- sudo ufw deny http
- sudo ufw allow https
- sudo ufw deny 23/tcp
- sudo ufw --force enable
- sudo ufw status verbose

## Verification Result
UFW was enabled successfully.

Expected active rules:

- 22/tcp ALLOW IN
- 80/tcp DENY IN
- 443 ALLOW IN
- 23/tcp DENY IN

The verbose status output is saved in:

- evidence/ufw_status_verbose.txt

## Blocked Traffic Test
A temporary Python HTTP server was started on the Kali VM on port 80.

The Windows host attempted to connect to:

192.168.178.128:80

Windows PowerShell result:

TcpTestSucceeded : False

This means the host could reach the VM network path, but the TCP connection to port 80 failed because UFW blocked inbound HTTP traffic.

The blocked-test result is saved in:

- evidence/http_block_test_result.txt

## Script
The firewall configuration script is saved in:

- scripts/ufw_configuration.sh

The script resets UFW, applies the required rules, enables UFW, and prints the final verbose status.

## Evidence Files

| File | Purpose |
|---|---|
| scope.md | Defines task scope and safety limits |
| evidence/ufw_status_verbose.txt | Active UFW rules |
| evidence/http_block_test_result.txt | Blocked HTTP test documentation |
| scripts/ufw_configuration.sh | Runnable UFW configuration script |
| screenshots/T2_01_UFW_Status_Verbose.png | Screenshot of active firewall rules |
| screenshots/T2_02_HTTP_Blocked_Test.png | Screenshot of blocked port 80 test |
| screenshots/T2_03_UFW_Configuration_Script.png | Screenshot of firewall script |

## Ethical Use and Safety
Firewall changes should only be made on systems you own or are authorized to administer.

For this task:

- Only a local Kali VM was configured.
- No production firewall was changed.
- SSH was allowed before enabling UFW to reduce lockout risk.
- A temporary local HTTP server was used only for testing.
- The denied traffic test was performed from the Windows host to the local VM.

## Conclusion
This task demonstrated how to configure UFW, apply allow and deny rules, verify firewall status, and test that denied inbound HTTP traffic is blocked.
