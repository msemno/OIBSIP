# Task 8 — Network Traffic Analysis with Wireshark

## Assessment Context

| Field | Value |
|---|---|
| Task | Task 8 — Capture Network Traffic with Wireshark |
| Environment | Local authorized lab |
| Capture interface | any |
| Capture file | captures/wireshark_capture.pcap |
| Capture type | Controlled traffic only |
| HTTP target | http://127.0.0.1:8088/ |
| DNS queries | example.com, owasp.org |

## Capture Summary

A live packet capture was performed for at least 2 minutes using Wireshark/dumpcap. The original capture was reviewed for privacy, then filtered to keep only controlled lab traffic.

Final clean capture contents:

| Protocol | Count |
|---|---:|
| HTTP | 14 |
| DNS | 8 |
| TCP | 74 |

Only controlled DNS names remained in the final PCAP:

- example.com
- owasp.org

## HTTP Analysis

HTTP traffic was generated using a local Python HTTP server on `127.0.0.1:8088`.

Example HTTP request observed:

| Frame | Source | Source Port | Destination | Destination Port | Method | Host | URI |
|---|---|---:|---|---:|---|---|---|
| 12 | 127.0.0.1 | 47800 | 127.0.0.1 | 8088 | GET | 127.0.0.1:8088 | / |

This proves that plaintext HTTP traffic was captured and inspected successfully.

## Unencrypted Data Observation

The HTTP request was visible in cleartext inside the packet capture.

Visible information included:

| Field | Observed |
|---|---|
| Method | GET |
| Host | 127.0.0.1:8088 |
| URI | / |
| Source | 127.0.0.1 |
| Destination | 127.0.0.1 |
| Destination port | 8088 |

No real credentials, private accounts, or sensitive third-party data were used.

Security observation: HTTP does not encrypt the application-layer request. Anyone who can observe the traffic path may be able to read request methods, paths, headers, and sometimes body content.

## DNS Analysis

DNS queries were generated intentionally using `nslookup`.

Observed DNS queries:

| Frame | Source | Destination | Query Name | Query Type |
|---|---|---|---|---|
| 1 | 192.168.1.2 | 192.168.1.1 | example.com | A |
| 3 | 192.168.1.2 | 192.168.1.1 | example.com | AAAA |
| 5 | 192.168.1.2 | 192.168.1.1 | owasp.org | A |
| 7 | 192.168.1.2 | 192.168.1.1 | owasp.org | AAAA |

This shows how DNS requests reveal the domain names being resolved unless encrypted DNS is used.

## TCP 3-Way Handshake Analysis

A complete TCP 3-way handshake was observed for the local HTTP connection to port 8088.

| Frame | Direction | Flags | Meaning |
|---|---|---|---|
| 9 | 127.0.0.1:47800 → 127.0.0.1:8088 | SYN | Client requests a new TCP connection |
| 10 | 127.0.0.1:8088 → 127.0.0.1:47800 | SYN, ACK | Server acknowledges and agrees to establish the connection |
| 11 | 127.0.0.1:47800 → 127.0.0.1:8088 | ACK | Client acknowledges the server response; connection is established |

After the handshake, frame 12 carried the HTTP request.

## HTTP vs HTTPS

HTTP sends application-layer data without encryption. In this capture, the request method, host, and URI were visible.

HTTPS uses TLS to encrypt the HTTP application content in transit. Wireshark may still show metadata such as IP addresses, ports, packet timing, packet sizes, and TLS handshake information, but the HTTP request path, headers, and body are normally encrypted unless decryption keys are intentionally provided.

## Glossary

| Term | Meaning |
|---|---|
| Packet | A small unit of network data transmitted between devices |
| Protocol | A set of rules that define how systems communicate |
| Port | A logical endpoint used to identify a service on a host |
| Payload | The actual carried data inside a packet after protocol headers |
| Handshake | A connection setup exchange, such as TCP SYN → SYN-ACK → ACK |

## Evidence Files

| File | Purpose |
|---|---|
| captures/wireshark_capture.pcap | Final clean packet capture |
| analysis/http_packets.txt | Extracted HTTP packet evidence |
| analysis/dns_packets.txt | Extracted DNS query evidence |
| analysis/tcp_handshake.txt | Extracted TCP handshake evidence |
| scope.md | Authorized capture scope |

## Privacy Review

The original capture contained unrelated DNS traffic, so it was filtered before publication. The final PCAP contains only controlled lab HTTP traffic and controlled DNS queries for `example.com` and `owasp.org`.

## Conclusion

This task demonstrated live packet capture, protocol filtering, HTTP plaintext analysis, DNS query inspection, and TCP 3-way handshake analysis. The key security lesson is that unencrypted protocols expose useful information to anyone who can observe network traffic, while encrypted protocols such as HTTPS protect application-layer content.
