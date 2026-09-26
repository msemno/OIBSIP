# Task 4 — Research Report: Common Network Security Threats

## Intern
Mahmoud Khaled

## Track
Security Analyst

## Objective
This report explains common network security threats, how each attack works, its potential impact, and practical mitigation strategies for network administrators.

## Introduction
Network security threats matter because modern organizations depend on reliable, trusted, and available network communication. If attackers can interrupt traffic, intercept data, spoof identities, or manipulate name resolution, they can affect business continuity, confidentiality, integrity, and user trust. Network administrators need to understand these threats so they can design layered defenses, monitor suspicious behavior, and respond quickly when incidents occur.

---

## Threat 1 — DoS and DDoS Attacks

### Description
A Denial-of-Service attack attempts to make a system, application, or network service unavailable to legitimate users. A Distributed Denial-of-Service attack uses many systems or traffic sources to overload the target.

### How the Attack Works
A DoS or DDoS attack may work by:

- exhausting bandwidth
- overwhelming server CPU or memory
- consuming application resources
- sending large volumes of protocol traffic
- abusing reflection or amplification techniques
- targeting DNS, web, API, or network infrastructure

In a DDoS attack, the traffic comes from multiple distributed sources, which makes blocking harder than a single-source DoS attack.

### Real-World Scenario
A public-facing web application may become unavailable because a botnet sends high volumes of traffic to the web server or to supporting infrastructure such as DNS. A known example is the 2016 Dyn DDoS incident, where DNS service disruption affected access to major online services.

### Impact
Possible impact includes:

- service outage
- revenue loss
- customer dissatisfaction
- SLA violation
- incident response cost
- distraction from another attack
- reduced trust in the affected service

### Indicators of Compromise
Network administrators may observe:

- sudden traffic spikes
- high bandwidth usage
- many requests from unusual regions or networks
- high error rates
- slow application response
- DNS or web service unavailability
- firewall, load balancer, or CDN alerts

### Mitigation Strategies
Recommended defenses include:

1. Use DDoS protection or scrubbing services for internet-facing systems.
2. Rate-limit suspicious traffic where appropriate.
3. Use CDN and Anycast-based protection for public web services.
4. Monitor traffic baselines and alert on abnormal spikes.
5. Harden DNS and web infrastructure.
6. Keep an incident response runbook for DDoS events.
7. Coordinate with ISP or hosting provider during large attacks.

---

## Threat 2 — Man-in-the-Middle Attacks

### Description
A Man-in-the-Middle attack occurs when an attacker positions themselves between two communicating parties and intercepts, relays, or changes traffic.

### How the Attack Works
A MITM attacker may attempt to:

- intercept traffic on an insecure network
- downgrade or block encryption
- spoof a network gateway
- abuse rogue Wi-Fi access points
- manipulate DNS or routing
- steal session cookies or credentials
- alter data before forwarding it

The attacker tries to make both parties believe they are communicating directly with each other.

### Real-World Scenario
A user connects to an untrusted Wi-Fi network and submits credentials to a website that is not properly protected with HTTPS. An attacker on the same network may intercept the traffic or redirect the user to a fake page.

### Impact
Possible impact includes:

- stolen credentials
- session hijacking
- sensitive data exposure
- transaction manipulation
- malware delivery
- loss of user trust
- compliance impact if regulated data is exposed

### Indicators of Compromise
Network administrators may observe:

- certificate warnings
- unexpected certificate issuers
- duplicate IP or MAC address behavior
- ARP anomalies
- unusual gateway changes
- suspicious proxy settings
- DNS responses pointing to unexpected IP addresses

### Mitigation Strategies
Recommended defenses include:

1. Enforce HTTPS/TLS for web applications.
2. Use HSTS for production web services.
3. Use VPN on untrusted networks.
4. Monitor ARP and gateway changes.
5. Use secure Wi-Fi authentication such as WPA2/WPA3 Enterprise.
6. Train users not to ignore certificate warnings.
7. Use certificate monitoring for public-facing domains.

---

## Threat 3 — IP Spoofing

### Description
IP spoofing occurs when an attacker sends packets with a forged source IP address. The attacker makes traffic appear to come from another system or network.

### How the Attack Works
IP spoofing may be used to:

- hide the true source of traffic
- bypass weak IP-based trust controls
- perform reflection or amplification attacks
- send malicious traffic that appears to come from a victim
- confuse logging and attribution

In reflection attacks, the attacker sends requests to third-party servers with the victim's IP address as the spoofed source. The third-party servers reply to the victim, increasing attack traffic.

### Real-World Scenario
An attacker sends UDP requests to public servers while spoofing the victim's IP address. The servers send amplified responses to the victim, creating a reflection/amplification DDoS attack.

### Impact
Possible impact includes:

- network congestion
- DDoS amplification
- misleading logs
- bypass of weak IP allowlists
- service disruption
- increased incident response complexity

### Indicators of Compromise
Network administrators may observe:

- outbound packets with invalid internal source addresses
- inbound replies to requests that internal systems did not send
- unusual UDP traffic spikes
- high traffic to or from reflection-prone services
- firewall logs showing impossible or unexpected source addresses

### Mitigation Strategies
Recommended defenses include:

1. Implement ingress and egress filtering.
2. Apply anti-spoofing controls on routers and firewalls.
3. Avoid trusting identity based only on source IP address.
4. Monitor for abnormal UDP traffic patterns.
5. Disable or restrict unnecessary UDP services.
6. Work with ISPs that apply source address validation.
7. Use DDoS protection for public-facing systems.

---

## Threat 4 — DNS Poisoning and DNS Spoofing

### Description
DNS poisoning or spoofing manipulates DNS responses so users are directed to the wrong IP address. This can redirect users from legitimate services to attacker-controlled systems.

### How the Attack Works
An attacker may attempt to:

- inject false DNS responses
- compromise DNS administrator credentials
- modify DNS records
- hijack domain registrar or DNS provider accounts
- redirect web or email traffic
- obtain unauthorized certificates after DNS control is changed

If the user receives a false DNS answer, they may connect to a fake server while believing it is the legitimate service.

### Real-World Scenario
A domain's DNS records are modified so that website or email traffic is redirected to attacker-controlled infrastructure. CISA has issued guidance on DNS infrastructure tampering because attackers can redirect and intercept web and mail traffic by altering DNS records.

### Impact
Possible impact includes:

- credential theft
- phishing at a trusted domain
- email interception
- website redirection
- malware delivery
- certificate abuse
- long-term trust damage

### Indicators of Compromise
Network administrators may observe:

- DNS records changed without approval
- unexpected A, MX, or NS records
- certificate transparency logs showing unknown certificates
- users reaching wrong websites
- mail delivery anomalies
- DNS responses from unexpected resolvers
- domain registrar account alerts

### Mitigation Strategies
Recommended defenses include:

1. Protect DNS registrar and DNS provider accounts with MFA.
2. Audit DNS records regularly.
3. Monitor certificate transparency logs.
4. Use DNSSEC where appropriate.
5. Restrict who can modify DNS records.
6. Use strong passwords and password managers for DNS administration.
7. Monitor authoritative DNS changes.
8. Keep an incident response process for DNS tampering.

---

## Comparison Table

| Threat | Attack Vector | Who Is at Risk | Difficulty to Execute | Ease of Mitigation | Main Defensive Priority |
|---|---|---|---|---|---|
| DoS/DDoS | Traffic flooding, resource exhaustion, reflection/amplification | Public websites, APIs, DNS services, internet-facing networks | Medium to High depending on scale | Medium | DDoS protection, traffic monitoring, provider coordination |
| Man-in-the-Middle | Interception, rogue Wi-Fi, ARP/DNS/routing manipulation | Users on untrusted networks, weakly encrypted applications | Medium | Medium | HTTPS/TLS, secure Wi-Fi, certificate monitoring |
| IP Spoofing | Forged source IP packets | Networks without anti-spoofing controls, public services | Medium | Medium | Ingress/egress filtering and anti-spoofing controls |
| DNS Poisoning/Spoofing | False DNS responses, DNS account compromise, record tampering | Domain owners, email users, website users | Medium | Medium | MFA, DNS record audits, DNSSEC, certificate transparency monitoring |

---

## Key Takeaways for Network Administrators

1. Availability is a security requirement. DDoS attacks can interrupt business even when no data is stolen.
2. Encryption and identity validation reduce interception risk. HTTPS, HSTS, secure Wi-Fi, and certificate monitoring help defend against MITM scenarios.
3. DNS is critical infrastructure. DNS account security, record auditing, DNSSEC, and certificate transparency monitoring should be treated as core controls.

---

## References

1. CISA — Understanding and Responding to Distributed Denial-of-Service Attacks  
   https://www.cisa.gov/sites/default/files/publications/understanding-and-responding-to-ddos-attacks_508c.pdf

2. NIST CSRC Glossary — Man-in-the-Middle Attack  
   https://csrc.nist.gov/glossary/term/man_in_the_middle_attack

3. CISA — UDP-Based Amplification Attacks  
   https://www.cisa.gov/news-events/alerts/2014/01/17/udp-based-amplification-attacks

4. CISA — Emergency Directive 19-01: Mitigate DNS Infrastructure Tampering  
   https://www.cisa.gov/sites/default/files/ed-19-01%20%281%29.pdf

5. NIST SP 800-189 — Resilient Interdomain Traffic Exchange: BGP Security and DDoS Mitigation  
   https://csrc.nist.gov/pubs/sp/800/189/final

6. MITRE ATT&CK — Network Denial of Service: Reflection Amplification  
   https://attack.mitre.org/techniques/T1498/002/
