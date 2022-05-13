-- Вывести количество продавцов, которые работают в конкретном магазине с сортировкой по shop_id
select shop.shop_id, shop_name, count(sa.shop_assistant_id)
from schedule_in_shop
         join shop on schedule_in_shop.shop_id = shop.shop_id
         join rest_schedule on rest_schedule.shop_assistant_id = schedule_in_shop.id
         join schedule on schedule.worktime_id = rest_schedule.worktime_id
         join shop_assistant sa on rest_schedule.shop_assistant_id = sa.shop_assistant_id
group by shop.shop_id, shop_name
order by shop.shop_id;