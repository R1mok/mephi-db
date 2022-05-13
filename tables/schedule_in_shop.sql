create table schedule_in_shop
(
    shop_id integer not null
        constraint schedule_in_shop_shop_shop_id_fk
            references shop
            on update cascade on delete restrict,
    id      integer not null
        constraint schedule_in_shop_pk
            primary key
        constraint schedule_in_shop_rest_schedule_shop_assistant_id_fk
            references rest_schedule
            on update cascade on delete restrict
);

alter table schedule_in_shop
    owner to postgres;

