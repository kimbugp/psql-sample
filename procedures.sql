CREATE OR REPLACE FUNCTION create_account (_email text, _password text, _name text = NULL, _is_staff BOOLEAN = FALSE)
    RETURNS SETOF users
    AS $func$
BEGIN
    RETURN QUERY WITH u AS (
INSERT INTO users (email,
            PASSWORD,
            name,
            is_staff)
        VALUES (_email,
            _password,
            _name,
            _is_staff)
    RETURNING
        *)
    TABLE u;
END
$func$
LANGUAGE plpgsql;

