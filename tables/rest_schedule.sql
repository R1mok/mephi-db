create table rest_schedule
(
    shop_assistant_id integer not null
        constraint rest_schedule_pk
            primary key
        constraint rest_schedule_shop_assistant_shop_assistant_id_fk
            references shop_assistant
            on update cascade on delete restrict,
    break_begin       time,
    break_end         time,
    worktime_id       integer not null
        constraint rest_schedule_schedule_worktime_id_fk
            references schedule
            on update cascade on delete restrict
);

alter table rest_schedule
    owner to postgres;

create unique index rest_schedule_shop_assistant_id_uindex
    on rest_schedule (shop_assistant_id);

