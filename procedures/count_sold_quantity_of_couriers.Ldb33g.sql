create function count_sold_quantity_of_couriers(cur refcursor) returns refcursor
    language plpgsql
as
$$
DECLARE
begin
    create temporary table sum_clothes_in_order
    (
        order_id    int primary key,
        sum_clothes int
    ) on commit drop;
    create temporary table sum_clothes_in_set
    (
        order_id    int primary key,
        sum_clothes int
    ) on commit drop;
    insert into sum_clothes_in_order (select clothes_in_order.order_id,
                                             SUM(clothes_in_order.quantity_in_order) as summary_clothes
                                      from clothes_in_order
                                               JOIN customer_order on clothes_in_order.order_id = customer_order.order_id
                                      group by clothes_in_order.order_id);
    insert into sum_clothes_in_set (select order_id,
                                           SUM(quantity_in_set * set_in_order.quantity_in_order) as summary_clothes_in_set
                                    from clothes_in_set
                                             JOIN set_in_order on set_in_order.set_id = clothes_in_set.set_id
                                    group by set_in_order.order_id);

    open cur for (select sum_clothes_in_order.order_id,
                                         ((case
                                              when sum_clothes_in_set.sum_clothes is null then 0
                                              else sum_clothes_in_set.sum_clothes end) +
                                         (case
                                                   when sum_clothes_in_order.sum_clothes is null then 0
                                                   else sum_clothes_in_order.sum_clothes end)) as sum_clothes
                                  from sum_clothes_in_set
                                           full join sum_clothes_in_order on sum_clothes_in_set.order_id = sum_clothes_in_order.order_id);
    return cur;
end;
$$;

alter function count_sold_quantity_of_couriers(refcursor) owner to postgres;

