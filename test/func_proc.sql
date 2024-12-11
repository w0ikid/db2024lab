-- 1
CREATE FUNCTION increment_by_n(a INT, b INT) RETURNS INT AS $$ 
BEGIN 
    RETURN a + b;
END:
$$ LANGUAGE plpgsql;

CREATE PROCEDURE print_message(IN input VARCHAR(20), OUT raisedString VARCHAR(20))
BEGIN
    RAISE NOTICE 'Some Text', input;
END;

CALL print_message('sometext')
