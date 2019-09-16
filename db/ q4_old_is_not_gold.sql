WITH movie_list AS (
    SELECT
        cast(round(premiered / 10) AS int) || '0s' AS decade,
        title_id
    FROM
        titles
    WHERE
        premiered IS NOT NULL
)
SELECT
    decade,
    count(title_id)
FROM
    movie_list
GROUP BY
    decade
ORDER BY
    decade DESC,
    count(title_id);

