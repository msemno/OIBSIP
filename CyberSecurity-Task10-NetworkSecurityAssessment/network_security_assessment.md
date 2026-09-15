# Task 10 — Full Network Security Assessment Report

## Intern
Mahmoud Khaled

## Track
Security Analyst

## Executive Summary
A structured security assessment was performed against a local authorized lab environment. The assessment used Nmap for service discovery, Wireshark for packet analysis, and Nikto for web server assessment where a web service was present.

The target was localhost, 127.0.0.1. No public, third-party, company, or production system was tested.

The assessment identified one medium-risk exposure, two low-risk issues, and four informational observations. The most important practical risks were local database service exposure, missing web security headers, and plaintext HTTP traffic visibility in the lab capture.

## Scope
Target: 127.0.0.1

Testing window: 15 September 2026

In-scope services:
- 3306/tcp — MySQL/MariaDB-related service
- 4280/tcp — HTTP Apache DVWA service
- 8080/tcp — checked and found closed after Burp was closed

Allowed activities:
- Nmap service/version and OS detection
- Wireshark capture of own generated lab traffic
- HTTP, DNS, and ARP traffic analysis
- Nikto scan against the detected local web server
- Non-destructive validation

Excluded activities:
- Public website testing
- Company system testing
- Third-party target testing
- Denial-of-service testing
- Credential theft
- Destructive exploitation

## Methodology

### Phase 1 — Reconnaissance
Nmap was used to identify open ports and service information.

Command performed:
sudo nmap -sV -O -p 3306,4280,8080 127.0.0.1 -oN nmap_results.txt

Results:
- 3306/tcp open mysql?
- 4280/tcp open http Apache httpd 2.4.68 ((Debian))
- 8080/tcp closed http-proxy

OS detection was attempted. Nmap did not produce an exact OS match, so the OS result is treated as an estimate rather than a confirmed finding.

### Phase 2 — Traffic Analysis
A Wireshark/dumpcap capture was performed for 309.98 seconds, satisfying the 5+ minute requirement.

The original capture was reviewed and filtered to preserve privacy. The final published capture contains only controlled lab traffic.

Final clean capture:
captures/wireshark_capture.pcap

Protocol evidence:
- HTTP: 4 packets
- DNS: 8 packets
- ARP: 4 packets
- TCP: 23 packets

HTTP traffic:
- Host: 127.0.0.1:8089
- Example request: GET /

DNS traffic:
- example.com
- owasp.org

ARP traffic:
- ARP request/reply traffic between 192.168.1.2 and 192.168.1.1

### Phase 3 — Web Vulnerability Scan
Because Nmap identified a web service on port 4280, Nikto was run against the local DVWA web server.

Nikto output:
scans/nikto_task10.txt

Nikto identified:
- PHP version exposed through X-Powered-By
- Missing Content-Security-Policy
- Missing Referrer-Policy
- Missing Permissions-Policy
- Missing Strict-Transport-Security
- Missing X-Content-Type-Options
- Login page discovered at /login.php
- X-Frame-Options modernization recommendation

## Findings Summary

| Severity | Count |
|---|---:|
| Critical | 0 |
| High | 0 |
| Medium | 1 |
| Low | 2 |
| Informational | 4 |

## Key Findings

### T10-F01 — Local database service exposed
Severity: Medium

Nmap identified a MySQL/MariaDB-related service on port 3306. In the local lab this supports DVWA, but in real environments database services should not be broadly exposed.

Recommended fix:
Restrict database access to trusted application hosts, bind to localhost where possible, enforce strong credentials, and apply least privilege.

### T10-F04 — Missing HTTP security headers
Severity: Low

Nikto identified missing web security headers on the local web service.

Recommended fix:
Add appropriate security headers including Content-Security-Policy, X-Content-Type-Options, Referrer-Policy, and Permissions-Policy. Configure HSTS only after HTTPS is correctly enabled.

### T10-F05 — Plaintext HTTP traffic visible
Severity: Low

Wireshark showed that local HTTP traffic exposed method, host, URI, IP addresses, and port information.

Recommended fix:
Use HTTPS/TLS for web applications, especially where authentication, session data, or sensitive information may be transmitted.

## Evidence

| Evidence | File |
|---|---|
| Scope | scope.md |
| Nmap results | nmap_results.txt |
| Capture metadata | evidence/task10_capture_metadata.txt |
| Clean Wireshark PCAP | captures/wireshark_capture.pcap |
| HTTP analysis | analysis/http_analysis.txt |
| DNS analysis | analysis/dns_analysis.txt |
| ARP analysis | analysis/arp_analysis.txt |
| Nikto scan | scans/nikto_task10.txt |
| Findings register | findings_register.md |
| Remediation roadmap | remediation_roadmap.md |

## Remediation Roadmap
The remediation roadmap is documented separately in:

remediation_roadmap.md

Highest priorities:
1. Restrict unnecessary database exposure.
2. Add missing HTTP security headers.
3. Avoid plaintext HTTP for sensitive services.
4. Reduce version disclosure.
5. Monitor DNS and ARP behavior in production environments.

## Retest Plan
After remediation:

1. Re-run Nmap and confirm only expected services are exposed.
2. Re-run Nikto and confirm web security header findings are reduced.
3. Capture controlled traffic again and verify sensitive application data is protected.
4. Review DNS and ARP traffic for unexpected behavior.
5. Update the findings register with fixed or accepted-risk status.

## Conclusion
This assessment demonstrated an end-to-end local network security assessment workflow. Nmap identified services, Wireshark captured and analyzed HTTP, DNS, and ARP traffic, and Nikto reviewed the local web service. The main lesson is that a security assessment should combine discovery, traffic analysis, validation, risk rating, and remediation planning.
