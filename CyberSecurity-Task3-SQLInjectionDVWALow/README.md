# Task 3 — SQL Injection on DVWA Low Security

## Intern
Mahmoud Khaled

## Track
Security Analyst

## Objective
The objective of this task is to demonstrate a classic SQL Injection vulnerability using the DVWA SQL Injection module on Low security level, document the payloads used, explain the exposed data, and describe how developers can prevent the vulnerability.

## Authorized Scope
Target: http://127.0.0.1:4280/

Environment: Local DVWA Docker container running on the assessor's Kali Linux VM.

Only the local DVWA lab was tested. No public, company, third-party, or production system was tested.

## Tools Used
- Kali Linux 2026.3
- Docker
- DVWA
- Firefox browser
- Linux terminal

## DVWA Setup
DVWA was run locally using Docker and exposed only on localhost.

Docker container name:

dvwa-task3

Local URL:

http://127.0.0.1:4280/

DVWA login used:

Username: admin

Password: password

The DVWA database was created/reset from the Setup / Reset DB page.

## Security Level
The DVWA security level was set to Low.

Evidence:

screenshots/T3_01_DVWA_Low_Security.png

## Tested Module
DVWA module:

SQL Injection

The test was performed through the User ID input field.

## Baseline Test
Normal input:

1

Observed output:

ID: 1
First name: admin
Surname: admin

Meaning:

The application returned only the user record for ID 1. This confirmed the normal expected behavior before injection.

Evidence:

screenshots/T3_02_SQLi_Baseline_ID1.png

## Payload 1
Payload:

' OR '1'='1

Observed output:

The application returned multiple users:

- admin admin
- Gordon Brown
- Hack Me
- Pablo Picasso
- Bob Smith

Why it worked:

The payload injected an OR condition that is always true. Because '1'='1' is always true, the database returned multiple rows instead of only the row matching a single ID.

Evidence:

screenshots/T3_03_SQLi_Payload1_OR_1_EQUALS_1.png

## Payload 2
Payload:

1' OR '1'='1' -- -

Observed output:

The application returned multiple users:

- admin admin
- Gordon Brown
- Hack Me
- Pablo Picasso
- Bob Smith

Why it worked:

The payload started with a normal ID value, injected an always-true OR condition, and used the SQL comment sequence to ignore the remaining part of the original query.

Evidence:

screenshots/T3_04_SQLi_Payload2_Comment_Bypass.png

## What Data Was Exposed
The SQL Injection exposed user identity fields from the DVWA database:

- ID values
- First names
- Surnames

In this lab, the exposed data was intentionally vulnerable sample data. In a real application, the same weakness could expose sensitive user records.

## What is SQL Injection?
SQL Injection is a vulnerability where user-controlled input is inserted into a SQL query without safe handling.

If the application builds SQL queries by directly joining user input into the query string, the database may treat part of the input as SQL code instead of normal data.

A vulnerable query may conceptually look like:

SELECT first_name, last_name FROM users WHERE user_id = '$id';

If the user input is not parameterized, an attacker can change the query logic.

## Business Risk
In a real application, SQL Injection could allow an attacker to:

- read unauthorized records
- bypass application logic
- enumerate database contents
- extract sensitive information
- modify or delete data if database permissions allow it
- cause business, legal, and compliance impact

## Developer Remediation
The correct fix is to use parameterized queries or prepared statements.

Prepared statements separate SQL code from user input. The database treats the input as data only, not executable SQL syntax.

## PHP PDO Safe Example
Conceptual safe pattern:

$statement = $pdo->prepare("SELECT first_name, last_name FROM users WHERE user_id = ?");
$statement->execute([$id]);
$rows = $statement->fetchAll();

Why this is safer:

The placeholder is bound separately from the SQL query, so payloads like ' OR '1'='1 are treated as input data instead of SQL logic.

## Python Safe Example
Conceptual safe pattern:

cursor.execute("SELECT first_name, last_name FROM users WHERE user_id = %s", (user_id,))
rows = cursor.fetchall()

Why this is safer:

The database driver handles the input as a parameter instead of allowing it to modify the SQL query structure.

## Additional Defenses
- Validate input type and length.
- Use least-privilege database accounts.
- Avoid exposing detailed database errors to users.
- Log suspicious input patterns.
- Test applications for SQL Injection before deployment.
- Use secure coding reviews and automated security testing.

## Evidence Files

| File | Purpose |
|---|---|
| sql_injection_notes.md | Payload log and analysis |
| screenshots/T3_01_DVWA_Low_Security.png | DVWA Low security evidence |
| screenshots/T3_02_SQLi_Baseline_ID1.png | Normal baseline request |
| screenshots/T3_03_SQLi_Payload1_OR_1_EQUALS_1.png | First SQL Injection payload |
| screenshots/T3_04_SQLi_Payload2_Comment_Bypass.png | Second SQL Injection payload |

## Ethical Use
This task was performed only against DVWA running locally on the assessor's own machine.

The same techniques must not be used against real websites, third-party systems, company systems, or production environments without explicit written authorization.

## Conclusion
This task demonstrated a classic SQL Injection vulnerability in DVWA Low security mode. Two payloads were tested, both returned multiple records by changing the SQL query logic. The correct remediation is to use parameterized queries, validate input, and apply least-privilege database access.
