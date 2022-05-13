create function distribute_break(min integer, shopid integer DEFAULT 1) returns void
    language plpgsql
as
$$
DECLARE
    break_time time; -- временные переменные
    cur_sa_id  int;
    start_work time;
    end_work   time;
    end_rest   time;
    start_rest time;
    delta      int;
    cur_count_in_shop int;
    curs scroll cursor (shopid int) for select shop_assistant.shop_assistant_id,
                                               break_begin,
                                               break_end,
                                               begin_time,
                                               end_time
                                        from schedule
                                                 join rest_schedule rs on schedule.worktime_id = rs.worktime_id
                                                 join shop_assistant
                                                      on rs.shop_assistant_id = shop_assistant.shop_assistant_id
                                                 join schedule_in_shop on rs.shop_assistant_id = schedule_in_shop.id
                                        where shop_id = shopid
                                        order by begin_time;

begin
    /* break_time = '11:00';
    min = (select count(sa.shop_assistant_id) -- получаем максимальное количество работников в магазине
           from schedule_in_shop
                    join shop on schedule_in_shop.shop_id = shop.shop_id
                    join rest_schedule on rest_schedule.shop_assistant_id = schedule_in_shop.id
                    join schedule on schedule.worktime_id = rest_schedule.worktime_id
                    join shop_assistant sa on rest_schedule.shop_assistant_id = sa.shop_assistant_id
           where shop.shop_id = shopid);
    loop
        cur_count_in_shop = check_count_working_shop_assistant(shopid, break_time); -- получаем количество людей, работающих в данный момент
        if cur_count_in_shop < min then
            min = cur_count_in_shop;
        end if;
        break_time = break_time + '00:30';
        exit when break_time = '22:30';
    end loop; */
    break_time := '11:00';
    open curs(shopid := shopid); -- открываем курсор с магазином
    loop
        delta := (check_count_working_shop_assistant(shopid, break_time) - min); -- извлекаем количество людей, которых мы
        while delta > 0 -- можем отправить отдыхать
            loop
                fetch curs into cur_sa_id, start_rest, end_rest, start_work, end_work; -- берем строку из курсора
                if start_work + '3:30' <= break_time and end_work - '4:00' >= break_time then -- если люди могут отдыхать и им самое то
                    update rest_schedule -- обновляем их начало и конец перерыва
                    set break_begin = break_time,
                        break_end   = break_time + '1:00'
                    where shop_assistant_id = cur_sa_id;
                else
                    move prior from curs; -- если им рано или поздно отдыхать, то возвращаем курсор в исходное состояние
                end if;
                delta = delta - 1; -- уменьшаем счетчик людей
            end loop;
        break_time = break_time + '00:30'; -- рассматриваем другое время
        exit when break_time = '22:30'; -- пока это время не равняется 22:30
    end loop;
end;
$$;

alter function distribute_break(integer, integer) owner to postgres;

