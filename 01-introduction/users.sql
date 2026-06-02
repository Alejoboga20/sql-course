/* Table Creation */
CREATE TABLE
    users (name varchar(10) UNIQUE);

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