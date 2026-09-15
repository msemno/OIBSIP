# Task 10 — Full Network Security Assessment Report

## Intern
Mahmoud Khaled

## Track
Security Analyst

## Objective
This task presents a structured security assessment of a local authorized lab environment using Nmap, Wireshark, and Nikto. The assessment includes service discovery, packet analysis, web server scanning, findings classification, and remediation planning.

## Authorized Scope
Target: 127.0.0.1

Environment: Local authorized lab only.

In-scope services:
- 3306/tcp — MySQL/MariaDB-related service
- 4280/tcp — Apache HTTP service running local DVWA
- 8080/tcp — checked and confirmed closed after Burp was closed

Excluded:
- public websites
- third-party systems
- company systems
- destructive testing
- denial-of-service testing
- credential theft
- real user data

## Tools Used
- Nmap 7.99
- Wireshark / dumpcap / tshark / editcap
- Nikto v2.6.1
- curl
- Linux terminal
- Local Python HTTP server for controlled HTTP traffic

## Methodology
The assessment followed three main phases:

1. Reconnaissance with Nmap.
2. Traffic analysis with Wireshark.
3. Web vulnerability scanning with Nikto because a local HTTP service was discovered.

## Phase 1 — Nmap Reconnaissance
Nmap command:

sudo nmap -sV -O -p 3306,4280,8080 127.0.0.1 -oN nmap_results.txt

Discovered services:
- 3306/tcp open mysql?
- 4280/tcp open http Apache httpd 2.4.68 ((Debian))
- 8080/tcp closed http-proxy

OS detection was attempted, but no exact OS match was confirmed. This is documented honestly as an estimate.

Evidence:
- nmap_results.txt
- screenshots/T10_01_Nmap_Service_Discovery.png

## Phase 2 — Wireshark Traffic Analysis
A packet capture was performed for 309.98 seconds, satisfying the 5+ minute capture requirement.

The raw capture was reviewed and filtered before publication. The final PCAP contains only controlled lab traffic.

Final PCAP:
- captures/wireshark_capture.pcap

Protocol counts:
- HTTP: 4
- DNS: 8
- ARP: 4
- TCP: 23

HTTP evidence:
- Local host: 127.0.0.1:8089
- Example request: GET /

DNS evidence:
- example.com
- owasp.org

ARP evidence:
- ARP request/reply between 192.168.1.2 and 192.168.1.1

Evidence files:
- analysis/http_analysis.txt
- analysis/dns_analysis.txt
- analysis/arp_analysis.txt
- evidence/task10_capture_metadata.txt
- screenshots/T10_02_HTTP_Analysis.png
- screenshots/T10_03_DNS_Analysis.png
- screenshots/T10_04_ARP_Analysis.png

## Phase 3 — Nikto Web Assessment
Nmap identified a local HTTP service on port 4280, so Nikto was run against the local DVWA service.

Nikto output:
- scans/nikto_task10.txt

Nikto identified mainly web hardening observations, including:
- PHP version exposed through X-Powered-By
- missing Content-Security-Policy
- missing Referrer-Policy
- missing Permissions-Policy
- missing Strict-Transport-Security
- missing X-Content-Type-Options
- login page discovered at /login.php
- X-Frame-Options modernization recommendation

Evidence:
- scans/nikto_task10.txt
- screenshots/T10_05_Nikto_Web_Assessment.png

## Findings Summary
| Severity | Count |
|---|---:|
| Critical | 0 |
| High | 0 |
| Medium | 1 |
| Low | 2 |
| Informational | 4 |

Full register:
- findings_register.md

Screenshot:
- screenshots/T10_06_Findings_Register.png

## Remediation Roadmap
The remediation plan is documented in:

- remediation_roadmap.md

Top priorities:
1. Restrict unnecessary database service exposure.
2. Add missing web security headers.
3. Avoid plaintext HTTP for sensitive services.
4. Reduce version disclosure.
5. Monitor DNS and ARP behavior in production environments.

## Required Files
| File | Purpose |
|---|---|
| network_security_assessment.md | Main technical and executive assessment report |
| nmap_results.txt | Nmap service/version and OS detection output |
| captures/wireshark_capture.pcap | Final clean Wireshark capture |
| scans/nikto_task10.txt | Nikto web assessment output |
| findings_register.md | Findings register with severity and fixes |
| remediation_roadmap.md | Prioritized remediation plan |
| scope.md | Written assessment scope |
| analysis/http_analysis.txt | HTTP packet analysis |
| analysis/dns_analysis.txt | DNS packet analysis |
| analysis/arp_analysis.txt | ARP packet analysis |

## Privacy Review
The original packet capture contained unrelated traffic and was not published. The final PCAP was filtered to keep only controlled HTTP, DNS, and ARP traffic needed for this task.

No public, third-party, company, or production system was tested.

## Ethical Use
This assessment was performed only in a local authorized lab environment. The techniques used here must not be applied to systems without explicit authorization.

## Conclusion
This task demonstrated a complete local network security assessment workflow: scoping, service discovery, packet capture, protocol analysis, web scanning, findings classification, remediation planning, and evidence handling.
