CREATE OR REPLACE VIEW get_user_ticket_report AS (
    SELECT
        u.id,
        u.name,
        u.email,
        count(t.id) ticket_number,
        json_agg(t) tickets
    FROM
        users u
    LEFT JOIN ticket t ON t.user_id = u.id
GROUP BY
    u.name,
    u.email,
    u.id);

CREATE OR REPLACE VIEW get_ticket_sales_report AS (
    SELECT
        st.movie_id,
        st.price,
        m.name,
        t.user_id,
        st.id
    FROM
        ticket t
    LEFT JOIN showtime st ON st.id = t.showtime_id
    JOIN movie m ON m.id = st.id);

CREATE OR REPLACE VIEW get_monthly_ticket_report AS (
    SELECT
        u.id,
        u.name,
        count(t.id) ticket_count,
        EXTRACT(MONTH FROM t.date_created) AS month,
        st.price
    FROM
        users u
        JOIN ticket t ON t.user_id = u.id
        LEFT JOIN showtime st ON st.id = t.showtime_id
    GROUP BY
        u.id,
        u.name,
        t.date_created,
        st.price);

