-- Вывести информацию о сотрудниках в магазине с заданным shop_id с сортировкой по началу рабочего времени
select rs.shop_assistant_id, schedule.begin_time, schedule.end_time, rs.break_begin, rs.break_end
from schedule
         join rest_schedule rs on schedule.worktime_id = rs.worktime_id
         join shop_assistant sa on rs.shop_assistant_id = sa.shop_assistant_id
         join schedule_in_shop sis on rs.shop_assistant_id = sis.id
where shop_id = 1 -- shopid
order by begin_time;