# Introduction to Aggregate Functions in SQL

## What Are Aggregate Functions?

Aggregate functions are special SQL functions that perform calculations over a **set of rows** and return a **single value**.

Instead of working on one row at a time, aggregate functions summarize data from multiple rows.

For example:

Imagine a table of employees:

| id  | name | salary |
| --- | ---- | ------ |
| 1   | John | 3000   |
| 2   | Jane | 5000   |
| 3   | Bob  | 4000   |

You might want to answer questions like:

- How many employees do we have?
- What is the average salary?
- What is the highest salary?
- What is the total amount paid in salaries?

Aggregate functions exist precisely for these kinds of questions.

---

# Why Are Aggregate Functions Important?

Databases are often used for reporting and analytics.

Instead of retrieving thousands of rows and calculating results in application code, SQL databases can perform these calculations directly.

For example:

```sql
SELECT AVG(salary)
FROM employees;
```

Result:

```text
4000
```

The database does all the work.

---

# The Most Common Aggregate Functions

## COUNT()

Counts rows.

### Example

```sql
SELECT COUNT(*)
FROM employees;
```

Result:

```text
3
```

---

### COUNT(column)

Counts only non-null values.

Example:

| id  | phone |
| --- | ----- |
| 1   | 123   |
| 2   | NULL  |
| 3   | 456   |

```sql
SELECT COUNT(phone)
FROM employees;
```

Result:

```text
2
```

The NULL value is ignored.

---

## SUM()

Adds values together.

```sql
SELECT SUM(salary)
FROM employees;
```

Result:

```text
12000
```

Calculation:

```text
3000 + 5000 + 4000
```

---

## AVG()

Calculates the average value.

```sql
SELECT AVG(salary)
FROM employees;
```

Result:

```text
4000
```

Calculation:

```text
(3000 + 5000 + 4000) / 3
```

---

## MIN()

Returns the smallest value.

```sql
SELECT MIN(salary)
FROM employees;
```

Result:

```text
3000
```

---

## MAX()

Returns the largest value.

```sql
SELECT MAX(salary)
FROM employees;
```

Result:

```text
5000
```

---

# Aggregate Functions and NULL Values

Most aggregate functions ignore NULL values.

Example:

| salary |
| ------ |
| 3000   |
| NULL   |
| 5000   |

```sql
SELECT AVG(salary)
FROM employees;
```

Result:

```text
4000
```

The NULL value is not included in the calculation.

---

# Using Multiple Aggregate Functions

You can calculate multiple statistics at once.

```sql
SELECT
    COUNT(*) AS total_employees,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary,
    SUM(salary) AS total_payroll
FROM employees;
```

Result:

| total_employees | average_salary | minimum_salary | maximum_salary | total_payroll |
| --------------- | -------------- | -------------- | -------------- | ------------- |
| 3               | 4000           | 3000           | 5000           | 12000         |

---

# Aggregates with GROUP BY

This is where aggregate functions become truly powerful.

Suppose we have:

| id  | country | salary |
| --- | ------- | ------ |
| 1   | USA     | 3000   |
| 2   | USA     | 5000   |
| 3   | Spain   | 4000   |
| 4   | Spain   | 6000   |

If we want the average salary per country:

```sql
SELECT
    country,
    AVG(salary)
FROM employees
GROUP BY country;
```

Result:

| country | avg  |
| ------- | ---- |
| USA     | 4000 |
| Spain   | 5000 |

The database creates groups and applies the aggregate function to each group independently.

---

# How GROUP BY Works

Think of SQL doing this internally:

```text
USA
 ├── 3000
 └── 5000

Spain
 ├── 4000
 └── 6000
```

Then:

```text
AVG(USA) = 4000
AVG(Spain) = 5000
```

---

# Aggregates with HAVING

`WHERE` filters rows before grouping.

`HAVING` filters groups after grouping.

Example:

```sql
SELECT
    country,
    COUNT(*)
FROM employees
GROUP BY country
HAVING COUNT(*) > 5;
```

Meaning:

> Show only countries that have more than 5 employees.

---

# WHERE vs HAVING

### WHERE

Filters individual rows.

```sql
SELECT *
FROM employees
WHERE salary > 3000;
```

---

### HAVING

Filters grouped results.

```sql
SELECT
    country,
    AVG(salary)
FROM employees
GROUP BY country
HAVING AVG(salary) > 4500;
```

---

# Aggregate Functions with DISTINCT

Sometimes you want to ignore duplicates.

Example:

| salary |
| ------ |
| 3000   |
| 3000   |
| 5000   |

### Without DISTINCT

```sql
SELECT AVG(salary)
FROM employees;
```

Result:

```text
3666.67
```

---

### With DISTINCT

```sql
SELECT AVG(DISTINCT salary)
FROM employees;
```

Result:

```text
4000
```

Calculation:

```text
(3000 + 5000) / 2
```

---

# PostgreSQL Aggregate Functions

PostgreSQL includes additional aggregate functions beyond the standard SQL ones. Examples include:

```sql
array_agg()
string_agg()
json_agg()
```

Examples:

```sql
SELECT string_agg(name, ', ')
FROM employees;
```

Result:

```text
John, Jane, Bob
```

```sql
SELECT array_agg(name)
FROM employees;
```

Result:

```text
{John,Jane,Bob}
```

These PostgreSQL-specific aggregates are useful for building arrays, strings, and JSON structures directly in SQL. :contentReference[oaicite:0]{index=0}

---

# Common Interview Question

Given this query:

```sql
SELECT
    department,
    AVG(salary)
FROM employees
GROUP BY department;
```

What happens first?

Many developers think:

```text
1. SELECT
2. GROUP BY
3. AVG
```

Actually SQL processes it conceptually as:

```text
1. FROM
2. WHERE
3. GROUP BY
4. Aggregate Functions
5. HAVING
6. SELECT
7. ORDER BY
8. LIMIT
```

Understanding this order helps explain many SQL errors and behaviors.

---

# Key Takeaways

- Aggregate functions summarize multiple rows into a single value.
- The most common aggregates are:
  - COUNT()
  - SUM()
  - AVG()
  - MIN()
  - MAX()
- Most aggregate functions ignore NULL values.
- GROUP BY allows aggregates to be calculated per group.
- HAVING filters grouped results.
- DISTINCT can be used inside aggregate functions.
- PostgreSQL provides advanced aggregates like:
  - array_agg()
  - string_agg()
  - json_agg()
- Aggregate functions are fundamental for reporting, analytics, dashboards, and business intelligence.
