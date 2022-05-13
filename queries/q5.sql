-- Вывести суммарное количество одежды в каждом заказе
select order_id, sum(summary_clothes_in_set) as summary_clothes_in_order
from ((select customer_order.order_id, SUM(quantity_in_set * set_in_order.quantity_in_order) as summary_clothes_in_set
       from customer_order
                JOIN set_in_order on set_in_order.order_id = customer_order.order_id
                join clothes_in_set on clothes_in_set.set_id = set_in_order.set_id
       group by set_in_order.order_id, customer_order.order_id)
      union
      (select customer_order.order_id, sum(quantity_in_order)
       from customer_order
                join clothes_in_order on customer_order.order_id = clothes_in_order.order_id
       group by clothes_in_order.order_id, customer_order.order_id)) as tmp_table
group by order_id
order by order_id;