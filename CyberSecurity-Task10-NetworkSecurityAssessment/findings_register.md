# Findings Register — Task 10 Full Network Security Assessment

## Assessment Context

| Field | Value |
|---|---|
| Target | 127.0.0.1 |
| Environment | Local authorized lab |
| Nmap file | nmap_results.txt |
| Wireshark file | captures/wireshark_capture.pcap |
| Nikto file | scans/nikto_task10.txt |

## Findings Register

| Finding ID | Description | Severity | Affected Asset | Recommended Fix |
|---|---|---|---|---|
| T10-F01 | Local MariaDB/MySQL service was discovered on port 3306. In this lab it supports DVWA, but exposed database services should be carefully restricted in real environments. | Medium | 127.0.0.1:3306 | Restrict database access to trusted application hosts only, bind to localhost where possible, enforce strong credentials, and apply least privilege. |
| T10-F02 | Local DVWA web service was discovered on port 4280 running Apache httpd 2.4.68 on Debian. | Informational | 127.0.0.1:4280 | Keep Apache patched, limit exposure to authorized networks, and monitor web access logs. |
| T10-F03 | Nikto identified PHP version exposure through the X-Powered-By header. | Informational | 127.0.0.1:4280 | Disable X-Powered-By exposure in PHP/web server configuration. |
| T10-F04 | Nikto identified missing HTTP security headers including Content-Security-Policy, Referrer-Policy, Permissions-Policy, Strict-Transport-Security, and X-Content-Type-Options. | Low | 127.0.0.1:4280 | Add appropriate security headers and test compatibility before production deployment. |
| T10-F05 | HTTP traffic was visible in plaintext during packet analysis. The method, host, URI, IPs, and destination port were observable. | Low | 127.0.0.1:8089 test HTTP service | Use HTTPS/TLS for web applications to encrypt application-layer traffic in transit. |
| T10-F06 | DNS queries for test domains were visible during packet analysis. | Informational | 192.168.1.2 → 192.168.1.1 | Consider encrypted DNS where appropriate and monitor DNS logs for suspicious destinations. |
| T10-F07 | ARP request/reply traffic was observed between the analyst host and gateway. This is normal LAN behavior, but ARP lacks authentication. | Informational | 192.168.1.2 ↔ 192.168.1.1 | In production networks, use switch security controls, monitoring, and segmentation to reduce ARP spoofing risk. |

## Severity Summary

| Severity | Count |
|---|---:|
| Critical | 0 |
| High | 0 |
| Medium | 1 |
| Low | 2 |
| Informational | 4 |

## Validation Notes

- Nmap confirmed open services on 127.0.0.1.
- Wireshark confirmed HTTP, DNS, and ARP traffic in the clean PCAP.
- Nikto confirmed web-server hardening observations on the local DVWA web service.
- No destructive testing was performed.
- No public, company, or third-party system was tested.
