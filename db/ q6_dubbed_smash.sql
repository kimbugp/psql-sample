SELECT DISTINCT
    primary_title,
    count(akas.title_id)
FROM
    titles
    INNER JOIN akas ON akas.title_id = titles.title_id
GROUP BY
    primary_title
ORDER BY
    count(akas.title_id)
    DESC
LIMIT 10;
