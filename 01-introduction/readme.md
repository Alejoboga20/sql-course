# Introduction to SQL Databases

## What Is a Database?

A database is a system designed to store, organize, retrieve, and manage data efficiently.

Instead of saving information in text files scattered across a computer, databases provide a structured way to store data and query it quickly.

Examples of data commonly stored in databases:

- Users of an application
- Products in an e-commerce store
- Bank transactions
- Orders and invoices
- Chat messages
- Sensor readings

---

# What Is a SQL Database?

A SQL Database (Structured Query Language Database) is a type of database that stores data in **tables** composed of:

- Rows (records)
- Columns (attributes)

Example:

| id  | name       | email          |
| --- | ---------- | -------------- |
| 1   | John Doe   | john@email.com |
| 2   | Jane Smith | jane@email.com |

Each row represents an entity and each column represents a property of that entity.

Popular SQL databases include:

- PostgreSQL
- MySQL
- Microsoft SQL Server
- Oracle Database
- SQLite

SQL databases use the SQL language to create, query, update, and delete data.

Example:

```sql
SELECT *
FROM users
WHERE country = 'Argentina';
```

---

# Core Concepts

## 1. Tables

Tables are the primary storage structure.

Example:

### Users Table

| id  | name | email          |
| --- | ---- | -------------- |
| 1   | John | john@email.com |
| 2   | Jane | jane@email.com |

### Orders Table

| id  | user_id | total |
| --- | ------- | ----- |
| 1   | 1       | 100   |
| 2   | 2       | 50    |

---

## 2. Rows and Columns

### Columns

Define the structure of the data.

```sql
CREATE TABLE users (
    id INTEGER,
    name VARCHAR(100),
    email VARCHAR(255)
);
```

### Rows

Actual stored data.

```text
(1, 'John', 'john@email.com')
```

---

## 3. Primary Keys

A Primary Key uniquely identifies each record.

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);
```

Example:

| id  | name |
| --- | ---- |
| 1   | John |
| 2   | Jane |

No two rows can share the same primary key value.

---

## 4. Foreign Keys

Foreign keys create relationships between tables.

```sql
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id)
);
```

This ensures every order belongs to a valid user.

---

## 5. Relationships

### One-to-One

One user has one profile.

### One-to-Many

One user can have many orders.

### Many-to-Many

Students can enroll in many courses and courses can contain many students.

Usually implemented with a junction table.

---

## 6. Constraints

Constraints enforce data integrity.

### NOT NULL

```sql
name VARCHAR(100) NOT NULL
```

### UNIQUE

```sql
email VARCHAR(255) UNIQUE
```

### CHECK

```sql
age INTEGER CHECK (age >= 18)
```

### FOREIGN KEY

Ensures referenced records exist.

---

## 7. Indexes

Indexes improve query performance.

Without an index:

```sql
SELECT * FROM users
WHERE email = 'john@email.com';
```

The database may scan every row.

With an index:

```sql
CREATE INDEX idx_users_email
ON users(email);
```

The database can locate records much faster.

---

## 8. Joins

Joins combine data from multiple tables.

```sql
SELECT
    users.name,
    orders.total
FROM users
JOIN orders
    ON users.id = orders.user_id;
```

Result:

| name | total |
| ---- | ----- |
| John | 100   |
| Jane | 50    |

---

# ACID Transactions

One of the most important characteristics of SQL databases is support for ACID transactions.

ACID stands for:

## Atomicity

Either all operations succeed or none do.

## Consistency

Data remains valid before and after transactions.

## Isolation

Concurrent transactions do not interfere with each other.

## Durability

Once committed, data survives crashes and restarts.

Example:

```sql
BEGIN;

UPDATE accounts
SET balance = balance - 100
WHERE id = 1;

UPDATE accounts
SET balance = balance + 100
WHERE id = 2;

COMMIT;
```

This guarantees money is never lost during a transfer.

---

# Why SQL Databases Are Structured

SQL databases use a predefined schema.

Example:

```sql
CREATE TABLE users (
    id INTEGER,
    name VARCHAR(100),
    age INTEGER
);
```

Every record must follow that structure.

Advantages:

- Predictable
- Strong validation
- Easier reporting
- Better data integrity

Disadvantages:

- Schema changes can be costly
- Less flexible for evolving data

---

# Limitations of SQL Databases

## Vertical Scaling

Traditionally SQL databases scale by upgrading a server:

- More CPU
- More RAM
- Faster disks

This is called vertical scaling.

Eventually a machine reaches its limits.

---

## Schema Rigidity

Changing structure often requires migrations.

Example:

```sql
ALTER TABLE users
ADD COLUMN phone VARCHAR(20);
```

Large tables can make migrations expensive.

---

## Distributed Complexity

Keeping ACID guarantees across many servers is difficult.

Distributed SQL databases exist, but they are significantly more complex.

Examples:

- CockroachDB
- YugabyteDB
- Google Spanner

---

## Handling Unstructured Data

Data such as:

- JSON documents
- Logs
- Social media posts
- Dynamic user profiles

may fit less naturally into a relational model.

---

# What Is NoSQL?

NoSQL means "Not Only SQL".

It refers to databases that do not rely exclusively on the relational model.

Major categories:

## Document Databases

Example:

```json
{
  "id": 1,
  "name": "John",
  "skills": ["Python", "TypeScript"]
}
```

Examples:

- MongoDB
- Couchbase

---

## Key-Value Databases

```text
user:1 -> John Doe
```

Examples:

- Redis
- DynamoDB

---

## Column-Family Databases

Examples:

- Cassandra
- HBase

Designed for massive distributed workloads.

---

## Graph Databases

Examples:

- Neo4j
- Amazon Neptune

Optimized for relationship-heavy data.

---

# SQL vs NoSQL

| Feature            | SQL            | NoSQL                        |
| ------------------ | -------------- | ---------------------------- |
| Data Model         | Tables         | Documents, Key-Value, Graphs |
| Schema             | Fixed          | Flexible                     |
| Relationships      | Excellent      | Usually weaker               |
| Transactions       | Strong ACID    | Often eventual consistency   |
| Horizontal Scaling | More difficult | Usually easier               |
| Data Integrity     | Very strong    | Usually application-managed  |
| Query Language     | Standard SQL   | Vendor-specific              |
| Analytics          | Excellent      | Varies                       |
| Flexibility        | Lower          | Higher                       |

---

# Scalability Comparison

## SQL Approach

Traditionally:

```text
Application
      |
 PostgreSQL
      |
 Bigger Server
```

Scale by upgrading hardware.

---

## NoSQL Approach

Typically:

```text
Application
      |
   Cluster
  /   |   \
Node Node Node
```

Scale by adding more servers.

This is called horizontal scaling.

---

# When Should You Use SQL?

SQL is usually the best choice when:

- Data relationships are important
- Transactions are critical
- Data consistency matters
- Reporting and analytics are required
- Financial systems are involved

Examples:

- Banking systems
- E-commerce platforms
- ERP systems
- CRM systems
- SaaS applications

---

# When Should You Use NoSQL?

NoSQL is often a better choice when:

- Schema changes frequently
- Data is semi-structured
- Massive horizontal scale is required
- Extremely high write throughput is needed
- Global distribution is important

Examples:

- Social networks
- Event ingestion systems
- Logging platforms
- IoT systems
- Real-time analytics

---

# Modern Reality

Today, most systems use both SQL and NoSQL.

Example architecture:

```text
Frontend
    |
Backend API
    |
+-------------------+
| PostgreSQL        |
| Business Data     |
+-------------------+

+-------------------+
| Redis             |
| Cache             |
+-------------------+

+-------------------+
| Elasticsearch     |
| Search            |
+-------------------+

+-------------------+
| S3                |
| Files             |
+-------------------+
```

This is called **polyglot persistence**.

Each database is chosen for the problem it solves best.

---

# Key Takeaways

- SQL databases store data in tables with predefined schemas.
- SQL excels at relationships, consistency, and transactions.
- ACID guarantees make SQL ideal for critical business systems.
- NoSQL databases provide more flexibility and horizontal scalability.
- NoSQL often sacrifices some consistency for scalability.
- Most modern applications combine multiple storage technologies.
- Choosing between SQL and NoSQL depends on the problem being solved, not on which technology is newer or more popular.
