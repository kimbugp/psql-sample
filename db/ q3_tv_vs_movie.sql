SELECT DISTINCT
    t1.type || '|' || count(t1.primary_title)
FROM
    titles t1,
    titles t2
WHERE
    t1.type = t2.type
GROUP BY
    t1.type,
    t1.primary_title
