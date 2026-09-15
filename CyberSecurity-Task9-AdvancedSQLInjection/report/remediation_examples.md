# SQL Injection Remediation Examples

## Root Cause

SQL injection happens when user-controlled input is inserted directly into a SQL query string. This allows the input to change the SQL logic.

Unsafe pattern:

SELECT first_name, last_name FROM users WHERE user_id = '<user_input>';

If the application directly concatenates input, a payload such as 1 OR 1=1 may return more records than intended.

## Secure Remediation Principle

Use parameterized queries or prepared statements.

Prepared statements separate SQL structure from user-controlled data. The database treats the input as a value, not as executable SQL logic.

## PHP PDO Secure Example

<?php
$user_id = $_POST['id'];

$stmt = $pdo->prepare(
    "SELECT first_name, last_name FROM users WHERE user_id = ?"
);

$stmt->execute([$user_id]);
$results = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

## PHP mysqli Secure Example

<?php
$user_id = $_POST['id'];

$stmt = mysqli_prepare(
    $connection,
    "SELECT first_name, last_name FROM users WHERE user_id = ?"
);

mysqli_stmt_bind_param($stmt, "i", $user_id);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);
?>

## Python Secure Example

user_id = request.form.get("id")

cursor.execute(
    "SELECT first_name, last_name FROM users WHERE user_id = %s",
    (user_id,)
)

rows = cursor.fetchall()

## Additional Controls

- Validate expected input type, such as numeric IDs.
- Use least-privilege database accounts.
- Do not display SQL errors or stack traces to users.
- Log suspicious input patterns.
- Keep database and framework versions patched.
- Retest after remediation.

## Retest Plan

1. Submit normal ID input and confirm normal output still works.
2. Submit 1 OR 1=1 and confirm it is not executed as SQL logic.
3. Submit ORDER BY and UNION SELECT payloads and confirm they fail safely.
4. Confirm no database error is displayed to the user.
5. Review source code to confirm prepared statements are used.
