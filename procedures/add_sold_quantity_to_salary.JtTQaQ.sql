create function add_sold_quantity_to_salary() returns void
    language plpgsql
as
$$
DECLARE
    _order_id      int;
    _sold_quantity int;
    curs           refcursor;
begin
    curs = count_sold_quantity_of_couriers('curs');
    loop
        fetch curs into _order_id, _sold_quantity;
        if not found then
            exit;
        end if;
        insert into salary(courier_id, sold_quantity)
        values ((select courier.courier_id
                 from courier
                          join delivery_note on delivery_note.courier_id = courier.courier_id
                          join customer_order on delivery_note.delivery_note_id = customer_order.delivery_note_id
                 where customer_order.order_id = _order_id
                   and delivery_note.shop_id is null), _sold_quantity);
    end loop;
    close curs;
end;
$$;

alter function add_sold_quantity_to_salary() owner to postgres;

