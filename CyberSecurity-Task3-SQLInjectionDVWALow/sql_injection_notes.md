# SQL Injection Notes — Task 3 DVWA Low Security

## Assessment Context

Intern: Mahmoud Khaled
Track: Security Analyst
Task: Task 3 — SQL Injection on DVWA Low Security
Target: http://127.0.0.1:4280/
Environment: Local DVWA Docker container
Security Level: Low
Module: DVWA SQL Injection
Authorization: Local lab only

## Objective

Demonstrate a classic SQL Injection vulnerability in DVWA Low security mode, document the payloads used, record the exposed output, and explain how the vulnerability can be prevented.

## Baseline Test

### Input

1

### Observed Output

ID: 1
First name: admin
Surname: admin

### Meaning

The application returned only the record matching ID 1. This is the expected normal behavior before injection.

### Screenshot

screenshots/T3_02_SQLi_Baseline_ID1.png

## Payload 1 — Boolean Always-True Injection

### Payload

' OR '1'='1

### Observed Output

The application returned multiple user records:

- admin admin
- Gordon Brown
- Hack Me
- Pablo Picasso
- Bob Smith

### Why It Worked

The payload changed the SQL query logic by adding an always-true condition.

The condition '1'='1' is always true, so the database returned multiple rows instead of only one matching ID.

### Data Exposed

The injection exposed user identity fields stored in the DVWA users table:

- ID values
- First names
- Surnames

### Screenshot

screenshots/T3_03_SQLi_Payload1_OR_1_EQUALS_1.png

## Payload 2 — Boolean Injection with SQL Comment

### Payload

1' OR '1'='1' -- -

### Observed Output

The application returned multiple user records:

- admin admin
- Gordon Brown
- Hack Me
- Pablo Picasso
- Bob Smith

### Why It Worked

This payload starts with a normal value, then injects an OR condition that is always true.

The comment sequence -- - comments out the rest of the original SQL query. This prevents the remaining query syntax from interfering with the injected condition.

### Data Exposed

The injection exposed the same user identity records as Payload 1:

- ID values
- First names
- Surnames

### Screenshot

screenshots/T3_04_SQLi_Payload2_Comment_Bypass.png

## Vulnerability Explanation

SQL Injection happens when user input is inserted directly into a SQL query without proper parameterization or validation.

A vulnerable query may look conceptually like this:

SELECT first_name, last_name FROM users WHERE user_id = '$id';

If the application directly places user input into the query, an attacker can submit SQL syntax instead of a normal ID value.

## Business Risk

If this vulnerability existed in a real application, an attacker could potentially:

- bypass intended query logic
- view records they should not access
- enumerate database content
- extract sensitive user data
- modify or delete data depending on database permissions

## Recommended Fix

Developers should use parameterized queries or prepared statements. User input should be treated as data, not executable SQL code.

Additional controls:

- validate expected input type
- use least-privilege database accounts
- avoid detailed database error messages
- monitor suspicious input patterns
- test applications for injection flaws before deployment

## Ethical Use

This test was performed only against DVWA running locally on the assessor's own machine.

No public, third-party, company, or production system was tested.
