WITH splitter (
    names,
    str
) AS (
    SELECT
        '',
        genres || ','
    FROM
        titles
    UNION ALL
    SELECT
        substr(str, 0, instr (str, ',')),
        substr(str, instr (str, ',') + 1)
    FROM
        splitter
    WHERE
        str != ''
)
SELECT DISTINCT
    names,
    (
        SELECT
            SUM(
                CASE WHEN genres LIKE names THEN
                    1
                ELSE
                    0
                END)
        FROM
            titles) AS total
FROM
    splitter
WHERE
    names != ''
GROUP BY
    names;

