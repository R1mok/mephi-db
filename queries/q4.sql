-- Вывести курьеров, которые доставили больше всего заказов
select courier_id, name, surname, couriers_orders
from (select courier.courier_id, courier.name, courier.surname, count(courier.courier_id) as couriers_orders
      from courier
               join delivery_note on delivery_note.courier_id = courier.courier_id
      group by courier, courier.courier_id
      order by courier.courier_id) as tmp_table
where couriers_orders = (
    select max(couriers_orders)
    from (select courier.courier_id, count(courier.courier_id) as couriers_orders
          from courier
                   join delivery_note on delivery_note.courier_id = courier.courier_id
          group by courier, courier.courier_id
          order by courier.courier_id) as tmp_table);