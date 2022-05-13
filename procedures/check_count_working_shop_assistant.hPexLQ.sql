create function check_count_working_shop_assistant(shopid integer, cur_time time without time zone) returns integer
    language plpgsql
as
$$
DECLARE
begin
    --выводим сколько продавцов из shopid работают во время cur_time
    return (select (select count(distinct shop_assistant_id)
                    from schedule_in_shop
                             join shop on shop.shop_id = schedule_in_shop.shop_id
                             join rest_schedule rs on rs.shop_assistant_id = schedule_in_shop.id
                             join schedule s on rs.worktime_id = s.worktime_id
                    where shop.shop_id = shopid) - count(*) as count_of_shop_assistants
            from (
                     select rs.worktime_id, s.begin_time, s.end_time, rs.break_begin
                     from schedule_in_shop
                              join shop on shop.shop_id = schedule_in_shop.shop_id
                             join rest_schedule rs on rs.shop_assistant_id = schedule_in_shop.id
                             join schedule s on rs.worktime_id = s.worktime_id
                     where shop.shop_id = shopid
                       and ((cur_time <= begin_time or cur_time > end_time) or
                            (cur_time > break_begin and cur_time <= break_end))) as count_of);
end;
$$;

alter function check_count_working_shop_assistant(integer, time) owner to postgres;

