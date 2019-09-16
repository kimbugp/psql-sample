WITH movie_list AS (
    SELECT
        cast(round(premiered / 10) AS int) || '0s' AS decade,
        title_id
    FROM
        titles
)
SELECT
    decade || '|' || count(title_id)
FROM
    movie_list
GROUP BY
    decade
