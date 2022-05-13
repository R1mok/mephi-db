create table schedule
(
    worktime_id serial
        constraint schedule_pk
            primary key
        constraint schedule_worktime_id_check
            check (worktime_id > 0),
    begin_time  time,
    end_time    time,
    constraint schedule_check
        check (begin_time < end_time)
);

alter table schedule
    owner to postgres;

