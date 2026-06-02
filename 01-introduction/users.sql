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
    ('test');

INSERT INTO
    users
values
    ('short_syntax')
    /* --------------------- */
    /* Update rows */
UPDATE users
SET
    "name" = 'testing'
WHERE
    "name" = 'test'