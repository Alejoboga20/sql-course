-- Nombre, apellido e IP, donde la última conexión se dió de 221.XXX.XXX.XXX
SELECT
    first_name,
    last_name,
    last_connection
FROM
    users
WHERE
    last_connection LIKE '221%';

-- Nombre, apellido y seguidores(followers) de todos a los que lo siguen más de 4600 personas
SELECT
    first_name,
    last_name,
    followers
FROM
    users
WHERE
    followers > 4600;

/* Between Operator */
SELECT
    first_name,
    last_name,
    followers
FROM
    users
WHERE
    followers BETWEEN 4600 AND 4700
ORDER BY
    followers desc;

/* COUNT MAX MIN AVG ROUND */
SELECT
    COUNT(*) as total_users,
    MIN(followers) as min_followers,
    MAX(followers) as max_followers,
    ROUND(AVG(followers)) as avg_followers,
    SUM(followers) / COUNT(*) as avg_manual
FROM
    users;

/* Group by */
select
    count(*),
    followers
from
    users
where
    followers between 4500 and 4999
group by
    followers
order by
    followers desc;

/* having */
select
    count(*),
    country
from
    users
group by
    country
having
    count(*) > 5
order by
    count(*) desc;