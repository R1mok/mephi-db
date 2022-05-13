create table clothes_in_shop
(
    shop_id    integer not null
        constraint clothes_in_shop_shop_shop_id_fk
            references shop
            on update cascade on delete restrict
        constraint clothes_in_shop_shop_id_check
            check (shop_id > 0),
    clothes_id integer not null
        constraint clothes_in_shop_clothes_clothes_id_fk
            references clothes
            on update cascade on delete restrict
        constraint clothes_in_shop_clothes_id_check
            check (clothes_id > 0),
    quantity   integer
        constraint clothes_in_shop_quantity_check
            check (quantity >= 0),
    constraint clothes_in_shop_pk
        primary key (shop_id, clothes_id)
);

alter table clothes_in_shop
    owner to postgres;

