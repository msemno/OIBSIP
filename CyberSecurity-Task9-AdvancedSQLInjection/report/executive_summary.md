# Executive Summary — Task 9 Advanced SQL Injection

## Overview

A SQL injection vulnerability was demonstrated in a controlled local DVWA Medium security lab. The test was performed only inside the authorized local environment and was used to understand how unsafe SQL query construction can allow user-controlled input to change database query behavior.

## Business Risk

In a real application, SQL injection can allow an attacker to access data beyond what the application intended to expose. Depending on the affected query and database permissions, this may lead to unauthorized data disclosure, account compromise, data modification, or full database exposure.

## What Was Demonstrated

The assessment demonstrated that the vulnerable parameter could be manipulated to:

- return multiple records instead of one selected user;
- identify the number of columns returned by the query;
- retrieve database metadata such as database name and version;
- enumerate database table names;
- enumerate column names from the users table.

## Evidence Summary

Key evidence was captured in:

- `evidence/payload_log.md`
- `screenshots/T9_04_SQLi_Payload1_OR_1_EQUALS_1.png`
- `screenshots/T9_05_Column_Count_ORDER_BY.png`
- `screenshots/T9_06_UNION_Database_Version.png`
- `screenshots/T9_07_Table_Enumeration.png`
- `screenshots/T9_08_Column_Enumeration_Users.png`

## Risk Rating

Severity: High in a real production system.

Reason: The vulnerability can allow unauthorized database enumeration and data exposure if present in a real application. In this internship task, impact was limited to a local DVWA training lab.

## Recommended Action

Developers should replace unsafe SQL string concatenation with parameterized queries or prepared statements. Input validation should also be applied, but validation alone is not a sufficient defense against SQL injection.

## Scope Limitation

No real website, third-party system, company system, or production database was tested. No password hashes or sensitive real-world data were extracted.
