/* Table Creation */
CREATE TABLE
    users (
        id SERIAL,
        name VARCHAR(100),
        first_name VARCHAR(50),
        last_name VARCHAR(50)
    );

/* --------------------- */
/* Insert Row */
INSERT INTO
    users (name)
VALUES
    ('alejo');

INSERT INTO
    users (name)
VALUES
    ('alejandro');

INSERT INTO
    users (name)
VALUES
    ('ale');

INSERT INTO
    users (name)
VALUES
    ('test');

INSERT INTO
    users
values
    ('short_syntax');

/* --------------------- */
/* Update rows */
UPDATE users
SET
    "name" = 'testing'
WHERE
    "name" = 'test';

/* --------------------- */
/* Select rows */
SELECT
    *
from
    users;

SELECT
    name
from
    users
LIMIT
    1
OFFSET
    1;

/* --------------------- */
/* Where clause */
SELECT
    *
FROM
    users
WHERE
    name = 'alejo';

SELECT
    *
FROM
    users
WHERE
    name LIKE 'ale%';

SELECT
    *
FROM
    users
WHERE
    name LIKE '%g';

/* --------------------- */
/* Delete */
DELETE FROM users
WHERE
    name LIKE 'ale%';

/* --------------------- */
/* DROP vs TRUNCATE Table */
DROP TABLE users;

TRUNCATE TABLE users;

/* String operators and functions */
SELECT
    id,
    UPPER(name) AS upper_name,
    LOWER(name) AS lower_name,
    LENGTH (name) AS name_length,
    CONCAT (id, ' - ', name) AS id_name,
    id || ' - ' || name AS bar_code,
    name
FROM
    users;

/* Substring and Position */
SELECT
    name,
    SUBSTRING(name, 0, POSITION(' ' in name)) as first_name,
    SUBSTRING(name, POSITION(' ' in name) + 1, LENGTH (name)) as last_name
FROM
    users;

UPDATE users
SET
    first_name = SUBSTRING(name, 0, POSITION(' ' in name)),
    last_name = SUBSTRING(name, POSITION(' ' in name) + 1, LENGTH (name))