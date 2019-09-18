SELECT
    t.primary_title
FROM
    titles t
    INNER JOIN crew c ON c.title_id = t.title_id
    INNER JOIN people p ON p.person_id = c.person_id
WHERE
    p.name = 'Mark Hamill'
    AND p.born = '1951'
INTERSECT
SELECT
    t.primary_title
FROM
    titles t
    INNER JOIN crew c ON c.title_id = t.title_id
    INNER JOIN people p ON p.person_id = c.person_id
WHERE
    p.name = 'George Lucas'
    AND p.born = '1944'
ORDER BY
    t.primary_title DESC;

