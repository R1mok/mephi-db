create function sum_sold_quantity() returns trigger
    language plpgsql
as
$$
DECLARE clothes_in_receipt integer;
    DECLARE clothes_in_set_in_receipt integer;
    DECLARE summary_clothes integer;
begin
    clothes_in_receipt := (select SUM(clothes_in_order.quantity_in_order) from clothes_in_order JOIN customer_order co on clothes_in_order.order_id = co.order_id);
    clothes_in_set_in_receipt := (select SUM(quantity_in_set*set_in_order.quantity_in_order) from clothes_in_set JOIN set_in_order on set_in_order.set_id = clothes_in_set.set_id);
    summary_clothes := clothes_in_receipt + clothes_in_set_in_receipt;
    UPDATE salary set sold_quantity=(summary_clothes + salary.sold_quantity) where shop_assistant_id=new.shop_assistant_id;
    return new;
    end;
$$;

alter function sum_sold_quantity() owner to postgres;

