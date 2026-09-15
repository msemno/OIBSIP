# Task 8 — Capture Network Traffic with Wireshark

## Intern
Mahmoud Khaled

## Track
Security Analyst

## Objective
This task demonstrates live packet capture and protocol analysis using Wireshark. The goal is to capture authorized traffic, apply protocol filters, analyze HTTP, DNS, and TCP traffic, identify a complete TCP 3-way handshake, and explain the security risk of unencrypted HTTP.

## Authorized Scope
| Field | Value |
|---|---|
| Environment | Local authorized lab |
| Capture interface | any |
| HTTP target | http://127.0.0.1:8088/ |
| DNS tests | example.com and owasp.org |
| Capture file | captures/wireshark_capture.pcap |
| Excluded | Public Wi-Fi traffic, company traffic, private accounts, credentials, unrelated browsing |

The final published PCAP was filtered to keep only controlled lab traffic.

## Tools Used
- Wireshark 4.6.6
- dumpcap
- tshark
- editcap
- curl
- nslookup
- Python local HTTP server

## Capture Process
A live capture was performed for more than 2 minutes using dumpcap on the `any` interface.

Controlled traffic was generated with:
- DNS lookups for example.com and owasp.org
- HTTP requests to a local Python HTTP server on 127.0.0.1:8088
- repeated HTTP HEAD requests to generate TCP connections

The original capture was reviewed for privacy and filtered before publication.

## PCAP File
Official capture file:

- captures/wireshark_capture.pcap

The final PCAP contains only controlled traffic.

## Protocol Counts
| Protocol | Count |
|---|---:|
| HTTP | 14 |
| DNS | 8 |
| TCP | 74 |

## HTTP Analysis
HTTP traffic was captured from the local Python HTTP server.

Example packet:

| Frame | Source | Source Port | Destination | Destination Port | Method | Host | URI |
|---|---|---:|---|---:|---|---|---|
| 12 | 127.0.0.1 | 47800 | 127.0.0.1 | 8088 | GET | 127.0.0.1:8088 | / |

This shows that HTTP request information can be visible in plaintext.

## Unencrypted Data Observation
Visible HTTP data included:
- method: GET
- host: 127.0.0.1:8088
- URI: /
- source and destination IP addresses
- destination port: 8088

No real credentials or private account data were used.

## DNS Analysis
DNS queries were captured for controlled test domains.

| Frame | Source | Destination | Query Name | Query Type |
|---|---|---|---|---|
| 1 | 192.168.1.2 | 192.168.1.1 | example.com | A |
| 3 | 192.168.1.2 | 192.168.1.1 | example.com | AAAA |
| 5 | 192.168.1.2 | 192.168.1.1 | owasp.org | A |
| 7 | 192.168.1.2 | 192.168.1.1 | owasp.org | AAAA |

DNS analysis shows that domain names can be visible during normal DNS resolution unless encrypted DNS is used.

## TCP 3-Way Handshake
A complete TCP handshake was identified for the local HTTP connection.

| Frame | Direction | Flags | Meaning |
|---|---|---|---|
| 9 | 127.0.0.1:47800 → 127.0.0.1:8088 | SYN | Client requests connection |
| 10 | 127.0.0.1:8088 → 127.0.0.1:47800 | SYN, ACK | Server acknowledges and agrees |
| 11 | 127.0.0.1:47800 → 127.0.0.1:8088 | ACK | Client confirms; connection established |

Frame 12 then carried the HTTP request.

## Why HTTP Is Dangerous
HTTP does not encrypt application-layer data. Anyone able to observe the traffic path may see request methods, paths, headers, and sometimes submitted data.

## How HTTPS Helps
HTTPS uses TLS to encrypt HTTP content in transit. Wireshark may still show metadata such as IP addresses, ports, timing, packet sizes, and TLS handshake information, but the application-layer HTTP content is normally encrypted.

## Glossary
| Term | Meaning |
|---|---|
| Packet | A unit of network data transmitted between systems |
| Protocol | A rule set that defines how systems communicate |
| Port | A logical endpoint used by a service on a host |
| Payload | The carried data inside a packet after headers |
| Handshake | A connection setup exchange, such as SYN, SYN-ACK, ACK |

## Evidence Files
| File | Purpose |
|---|---|
| captures/wireshark_capture.pcap | Final clean packet capture |
| analysis/http_packets.txt | Extracted HTTP packet evidence |
| analysis/dns_packets.txt | Extracted DNS query evidence |
| analysis/tcp_handshake.txt | Extracted TCP handshake evidence |
| analysis/task8_protocol_analysis.md | Full protocol analysis |
| scope.md | Authorized capture scope |

## Privacy Review
The original capture included unrelated DNS traffic, so it was filtered before publication. The final PCAP contains only controlled local HTTP traffic and DNS queries for example.com and owasp.org.

## Conclusion
This task demonstrated live capture, HTTP filtering, DNS filtering, TCP filtering, TCP handshake analysis, and plaintext HTTP inspection. The main security lesson is that unencrypted protocols expose useful information to anyone who can observe the network path.
