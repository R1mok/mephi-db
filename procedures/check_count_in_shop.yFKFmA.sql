create function check_count_in_shop() returns trigger
    language plpgsql
as
$$
DECLARE cnt integer;
begin
        cnt := (select clothes_in_shop.quantity from clothes_in_shop WHERE new.clothes_id = clothes_in_shop.clothes_id);
        if new.quantity_in_order > cnt
            then raise exception 'The shop doesnt have that many items.';
        else return new;
        end if;
    end;
$$;

alter function check_count_in_shop() owner to postgres;

