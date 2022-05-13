create table shop_assistant
(
    shop_assistant_id serial
        constraint shop_assistant_pk
            primary key
        constraint shop_assistant_shop_assistant_id_check
            check (shop_assistant_id > 0),
    name              varchar(50) not null
        constraint shop_assistant_name_check
            check ((name)::text ~ similar_to_escape('[A-ZА-Я][a-zа-я]{1,49}'::text)),
    surname           varchar(50) not null,
    born_date         date,
    passport_series   char(4)
        constraint shop_assistant_passport_series_check
            check (passport_series ~ similar_to_escape('[1-9][0-9]{3}'::text)),
    passport_id       char(6)
        constraint shop_assistant_passport_id_check
            check (passport_id ~ similar_to_escape('[1-9][0-9]{5}'::text))
);

alter table shop_assistant
    owner to postgres;

create unique index shop_assistant_passport_series_passport_id_uindex
    on shop_assistant (passport_series, passport_id);

