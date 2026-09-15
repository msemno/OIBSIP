# Task 9 — Advanced SQL Injection

## Intern
Mahmoud Khaled

## Track
Security Analyst

## Objective
This task demonstrates advanced SQL injection testing in a controlled local DVWA Medium security lab. The goal is to manually understand the vulnerable request, test SQL injection payloads, enumerate database metadata, document exact outputs, and explain secure remediation.

## Authorized Scope
| Field | Value |
|---|---|
| Target | http://127.0.0.1:4280/ |
| Environment | Local DVWA lab |
| Security level | Medium |
| Module | DVWA SQL Injection |
| Authorization | My own local lab only |
| Excluded | Public websites, third-party systems, company systems, real accounts, real databases, destructive actions |

No testing was performed against any public, third-party, company, or production system.

## Tools Used
- DVWA
- Burp Suite
- Browser
- Linux terminal
- Markdown
- Manual SQL injection payloads

## Methodology
The testing was performed manually first. Burp Suite was used to intercept and inspect the HTTP request. Payloads were tested step by step and documented with exact observed outputs.

The workflow was:
1. Confirm DVWA Medium security level.
2. Capture a baseline request and response.
3. Test a boolean OR SQL injection condition.
4. Determine the number of columns using ORDER BY.
5. Confirm UNION SELECT compatibility.
6. Enumerate database name and version.
7. Enumerate table names.
8. Enumerate column names from the users table.
9. Document remediation using prepared statements.

## Baseline Result
Input / selected ID:

1

Observed result:

ID: 1
First name: admin
Surname: admin

Evidence:

screenshots/T9_02_SQLi_Baseline_ID1.png

## Burp Suite Request Analysis
Burp Suite was used to inspect the request sent to the DVWA SQL Injection module.

Evidence:

screenshots/T9_03_Burp_Baseline_Request.png

The public screenshot was sanitized so cookies, session IDs, and token values were not exposed.

## Payload Summary

| Step | Payload / Technique | Result |
|---|---|---|
| Baseline | id=1&Submit=Submit | Returned only ID 1 |
| Boolean OR | id=1+OR+1=1&Submit=Submit | Returned multiple user records |
| Column count | ORDER BY 1, 2, 3 | ORDER BY 3 failed; query likely has 2 columns |
| Database/version | UNION SELECT database(),version() | Returned dvwa and MariaDB version |
| Table enumeration | information_schema.tables | Returned guestbook, access_log, users, security_log |
| Column enumeration | information_schema.columns for users | Returned user_id, first_name, last_name, user, password, avatar, last_login, failed_login, role, account_enabled |

## Key Evidence

| File | Purpose |
|---|---|
| evidence/payload_log.md | Full payload log and exact outputs |
| scripts/sql_injection_exploit.sh | Commented/manual payload reference script |
| report/executive_summary.md | Manager-friendly risk summary |
| report/remediation_examples.md | Python/PHP remediation examples |
| scope.md | Authorized scope |

## Screenshots

| Screenshot | Purpose |
|---|---|
| screenshots/T9_01_DVWA_Medium_Security.png | DVWA Medium security proof |
| screenshots/T9_02_SQLi_Baseline_ID1.png | Baseline normal output |
| screenshots/T9_03_Burp_Baseline_Request.png | Sanitized Burp request |
| screenshots/T9_04_SQLi_Payload1_OR_1_EQUALS_1.png | Boolean OR SQL injection result |
| screenshots/T9_05_Column_Count_ORDER_BY.png | ORDER BY column-count test |
| screenshots/T9_06_UNION_Database_Version.png | Database/version extraction |
| screenshots/T9_07_Table_Enumeration.png | Table enumeration |
| screenshots/T9_08_Column_Enumeration_Users.png | Column enumeration |

## Technical Findings
The tested parameter was vulnerable to SQL injection because user-controlled input could alter SQL query logic. The boolean OR payload expanded the result set. ORDER BY testing showed that the original query likely returned two columns. UNION SELECT was then used to retrieve database metadata and enumerate schema information.

## Authentication-Bypass Requirement Handling
The official task mentions bypassing login authentication. In this local DVWA Medium execution, the tested module was the DVWA SQL Injection module, where the controllable input was the ID parameter rather than the main DVWA login form.

What was actually demonstrated was a boolean-condition bypass of normal record-selection logic. No real authentication bypass against the DVWA login page is claimed.

## Risk Rating
Severity in a real production application: High.

Reason: SQL injection can allow unauthorized database enumeration and data disclosure. In this internship task, the impact was intentionally limited to a local DVWA lab.

## Remediation
The primary remediation is to use parameterized queries or prepared statements so user input is treated as data, not executable SQL.

Additional recommendations:
- validate expected input types;
- use least-privilege database users;
- hide detailed SQL errors from users;
- log suspicious input patterns;
- patch database and framework components;
- retest after remediation.

Detailed code examples are in:

report/remediation_examples.md

## Ethical Use
This task was completed only in a local authorized DVWA lab. SQL injection testing must never be performed against real websites, third-party services, company systems, or production systems without written authorization.

## Conclusion
This task demonstrated manual SQL injection testing, Burp Suite request inspection, column-count discovery, UNION-based database metadata extraction, table enumeration, column enumeration, evidence handling, and developer-focused remediation. The main lesson is that SQL injection is not just about running payloads; a security analyst must understand the query logic, document exact evidence, and explain how developers should fix the root cause.

