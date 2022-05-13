create table shop
(
    shop_id            serial
        constraint shop_pk
            primary key
        constraint shop_shop_id_check
            check (shop_id > 0),
    shop_name          varchar(100) not null
        constraint shop_shop_name_check
            check ((shop_name)::text ~ similar_to_escape('[A-ZА-Я][a-zа-я0-9]{1,50}'::text)),
    working_time_begin time,
    working_time_end   time,
    rent_price         money
        constraint shop_rent_price_check
            check (rent_price > money(0)),
    cash_machines      integer
        constraint shop_cash_machines_check
            check (cash_machines >= 0),
    warehouse_size     integer
        constraint shop_warehouse_size_check
            check (warehouse_size > 0),
    constraint shop_check
        check (working_time_begin < working_time_end)
);

alter table shop
    owner to postgres;

create unique index shop_shop_name_uindex
    on shop (shop_name);

