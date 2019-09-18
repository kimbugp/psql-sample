SELECT
    t1.type,
    t1.primary_title,
    t1.runtime_minutes
FROM
    titles t1
    INNER JOIN titles t2 ON t2.type = t1.type
WHERE
    t1.runtime_minutes > t2.runtime_minutes
ORDER BY
    t1.type ASC,
    t1.primary_title ASC;

