WITH movie_list AS (
    SELECT
        cast(round(premiered / 10) AS int) || '0s' AS decade,
        title_id
    FROM
        titles
)
SELECT
    decade,
    round(cast(count(title_id) AS float) / (
        SELECT
            count(*)
        FROM titles) * 100, 4)
FROM
    movie_list
GROUP BY
    decade
ORDER BY
    decade DESC,
    count(title_id);

