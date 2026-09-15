# Remediation Roadmap — Task 10 Full Network Security Assessment

## Prioritization Method

Fixes were prioritized based on:

1. Potential security impact
2. Exposure level
3. Ease of remediation
4. Operational risk
5. Value for hardening the environment

## Roadmap

| Priority | Finding ID | Finding | Severity | Recommended Fix | Effort |
|---|---|---|---|---|---|
| 1 | T10-F01 | Local MariaDB/MySQL service discovered on port 3306 | Medium | Restrict database access to trusted local/application-only access, bind to localhost where possible, enforce least privilege, and review credentials. | Medium |
| 2 | T10-F04 | Missing HTTP security headers | Low | Add Content-Security-Policy, X-Content-Type-Options, Referrer-Policy, Permissions-Policy, and configure HSTS only after HTTPS is enabled. | Medium |
| 3 | T10-F05 | Plaintext HTTP traffic visible | Low | Use HTTPS/TLS for web applications and avoid transmitting sensitive data over HTTP. | Medium |
| 4 | T10-F03 | PHP version exposed through X-Powered-By | Informational | Disable X-Powered-By in PHP or web server configuration. | Easy |
| 5 | T10-F02 | Web service discovered on port 4280 | Informational | Keep Apache patched, restrict exposure to authorized networks, and monitor web logs. | Easy |
| 6 | T10-F06 | DNS queries visible | Informational | Monitor DNS activity and consider encrypted DNS where appropriate. | Medium |
| 7 | T10-F07 | ARP request/reply behavior observed | Informational | Use network segmentation, switch security controls, and ARP spoofing monitoring in production networks. | Hard |

## Immediate Actions

- Restrict unnecessary database exposure.
- Add missing web security headers.
- Avoid plaintext HTTP for sensitive services.
- Remove unnecessary version disclosure.
- Monitor local network behavior.

## Retest Plan

After remediation:

1. Re-run Nmap and confirm exposed services are expected.
2. Re-run Nikto and compare missing-header findings.
3. Capture traffic again and confirm sensitive web traffic is protected with HTTPS.
4. Review DNS and ARP behavior for suspicious or unexpected activity.
5. Update the findings register with remediation status.
