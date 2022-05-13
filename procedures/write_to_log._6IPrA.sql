create function write_to_log() returns trigger
    language plpgsql
as
$$
DECLARE
    cur_msg VARCHAR(100);

BEGIN
    IF TG_OP = 'INSERT' THEN
        cur_msg = 'ADD: ' || new.customer_id || ' ' || NEW.name || ' ' || NEW.surname || ' ' || NEW.phone;
        INSERT INTO logs (msg) VALUES (cur_msg);
        RETURN NEW;
    ELSEIF TG_OP = 'UPDATE' THEN
        cur_msg = 'UPDATE: ' || new.customer_id || ' '  || NEW.name || ' ' || NEW.surname || ' ' || NEW.phone;
        INSERT INTO logs (msg) VALUES (cur_msg);
        RETURN NEW;
    ELSEIF TG_OP = 'DELETE' THEN
        cur_msg = 'DELETE: ' || OLD.customer_id || ' '  || OLD.name || ' ' || OLD.surname || ' ' || OLD.phone;
        INSERT INTO logs (msg) VALUES (cur_msg);
        RETURN OLD;
    END IF;
END;
$$;

alter function write_to_log() owner to postgres;

