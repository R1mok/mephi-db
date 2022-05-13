-- Вывести имя, фамилию и номер телефона покупателей, которые расписались за доставленный заказ
select c.name, c.surname, c.phone
from customer_order
         join delivery_note dn on customer_order.delivery_note_id = dn.delivery_note_id
         join customer c on customer_order.customer_id = c.customer_id
where customer_signature notnull;
