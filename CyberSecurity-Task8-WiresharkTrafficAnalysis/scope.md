# Authorized Capture Scope

Task: Task 8 — Capture Network Traffic with Wireshark
Environment: Local authorized lab
Capture interface: any
Reason for interface choice: HTTP traffic to local DVWA uses loopback, while DNS traffic uses wlan0. The any interface captures my own generated lab traffic across both.
Capture source: My own machine only
HTTP target: http://127.0.0.1:4280/
DNS test: example.com lookup from my own terminal
Capture duration: At least 2 minutes
Protocols: HTTP, DNS, TCP
Excluded: Public Wi-Fi traffic from other users, third-party account logins, company traffic, credentials, private browsing, unrelated applications
Evidence required: wireshark_capture.pcap, HTTP screenshot, DNS screenshot, TCP handshake screenshot, README analysis
