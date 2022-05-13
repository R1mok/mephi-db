create table courier
(
    courier_id      serial
        constraint courier_pk
            primary key
        constraint courier_courier_id_check
            check (courier_id > 0),
    shop_id         integer     not null
        constraint courier_shop_shop_id_fk
            references shop
            on update cascade on delete restrict
        constraint courier_shop_id_check
            check (shop_id > 0),
    name            varchar(50) not null
        constraint courier_name_check
            check ((name)::text ~ similar_to_escape('[A-ZА-Я][a-zа-я]{1,49}'::text)),
    surname         varchar(50) not null,
    born_date       date,
    passport_series char(4)     not null
        constraint courier_passport_series_check
            check (passport_series ~ similar_to_escape('[1-9][0-9]{3}'::text)),
    passport_id     char(6)     not null
        constraint courier_passport_id_check
            check (passport_id ~ similar_to_escape('[1-9][0-9]{5}'::text))
);

alter table courier
    owner to postgres;

create unique index courier_passport_series_passport_id_uindex
    on courier (passport_series, passport_id);

