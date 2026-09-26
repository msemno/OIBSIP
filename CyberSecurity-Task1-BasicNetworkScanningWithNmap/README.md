# Task 1 — Basic Network Scanning with Nmap

## Intern
Mahmoud Khaled

## Track
Security Analyst

## Objective
The objective of this task is to perform basic network scanning using Nmap against a local machine, identify open ports and services, and document the security meaning of the results.

## Authorized Scope
Target: 127.0.0.1

Environment: Local Kali Linux VM

Only localhost was scanned. No public, third-party, company, or production system was tested.

## Tools Used
- Kali Linux 2026.3
- Nmap 7.99
- Python HTTP server
- Linux terminal

## What is Nmap?
Nmap, short for Network Mapper, is a network scanning tool used to discover hosts, open ports, running services, service versions, and sometimes operating system information.

Security analysts use Nmap during authorized assessments to understand what services are exposed on a system.

## Why Network Scanning Matters
Network scanning matters because exposed ports can reveal services that may need hardening, patching, access control, or monitoring.

A scan helps answer questions such as:

- Which ports are open?
- What services are listening?
- What service versions are exposed?
- Are unexpected services running?
- What risks may exist if these services are exposed?

## Lab Setup
A temporary local Python HTTP service was started on localhost port 8080.

Command used:

python3 -m http.server 8080 --bind 127.0.0.1 --directory local-web

The service was bound to 127.0.0.1, meaning it was only reachable from the local machine.

## Nmap Scans Performed

### 1. Basic Scan
Command:

nmap 127.0.0.1

Result summary:

8080/tcp open http-proxy

Explanation:

The basic scan identified one open TCP port. The service name appeared as http-proxy because basic Nmap scans often identify services based on common port mappings.

### 2. Service and Version Detection
Command:

nmap -sV 127.0.0.1

Result summary:

8080/tcp open http SimpleHTTPServer 0.6 (Python 3.14.7)

Explanation:

The service/version scan gave a more accurate result because Nmap actively probed the service. It confirmed that the open service was a Python SimpleHTTPServer.

### 3. OS Detection
Command:

sudo nmap -O 127.0.0.1

Result summary:

No exact OS matches for host.

Explanation:

OS detection was attempted, but Nmap did not return an exact match. This can happen when scanning localhost or when there is not enough network fingerprinting information for a confident result.

## Open Port Analysis

| Port | State | Service | Version | Purpose | Security Observation |
|---|---|---|---|---|---|
| 8080/tcp | Open | HTTP | SimpleHTTPServer 0.6 / Python 3.14.7 | Serves local web content from the test directory. | Safe in this lab because it is bound to 127.0.0.1. In production, exposed HTTP services should be reviewed, patched, monitored, and protected with access control and HTTPS where sensitive data is involved. |

## Evidence Files
| File | Purpose |
|---|---|
| scope.md | Defines the authorized testing scope |
| nmap_scan_results.txt | Structured scan results and analysis |
| scans/nmap_basic_scan.txt | Raw basic Nmap scan output |
| scans/nmap_service_version_scan.txt | Raw service/version scan output |
| scans/nmap_os_detection_scan.txt | Raw OS detection scan output |
| screenshots/T1_01_Nmap_Version.png | Nmap version evidence |
| screenshots/T1_02_Basic_Nmap_Scan.png | Basic scan screenshot |
| screenshots/T1_03_Service_Version_Scan.png | Service/version scan screenshot |
| screenshots/T1_04_OS_Detection_Scan.png | OS detection screenshot |

## Ethical Use Guidelines
Nmap must only be used on systems you own or have explicit permission to test.

For this task:

- Only localhost was scanned.
- No external IP address was scanned.
- No public website was scanned.
- No company or production system was scanned.
- The open service was intentionally created for this local lab.

Unauthorized scanning may be illegal, disruptive, or against acceptable-use policies.

## Conclusion
This task demonstrated how to use Nmap for basic port discovery, service/version detection, and OS detection in a local authorized lab. The scan found one open local HTTP service on port 8080 and documented its security relevance.
