WITH mark_hamill_titles AS (
    SELECT
        t.title_id
    FROM
        titles t
        INNER JOIN crew c ON c.title_id = t.title_id
        INNER JOIN people p ON p.person_id = c.person_id
    WHERE
        p.name = 'Mark Hamill'
        AND p.born = '1951'
)
SELECT
    count(DISTINCT crew.person_id)
FROM
    crew
WHERE
    crew.title_id IN mark_hamill_titles;

