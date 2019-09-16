WITH rating_count AS (
    SELECT
        title_id,
        avg(rating) average,
        cast(sum(votes) AS float) total
    FROM
        ratings
    GROUP BY
        title_id
)
SELECT
    t.primary_title,
    (total / (total + 25000)) * average + (25000 / (total + 25000)) * (sum(average * total) / sum(total)) weighted
FROM
    rating_count cte
    INNER JOIN titles t ON t.title_id = cte.title_id
GROUP BY
    cte.title_id
ORDER BY
    weighted DESC
LIMIT 250;

