create table delivery
(
    shop_id           integer not null
        constraint delivery_shop_shop_id_fk
            references shop
            on update cascade on delete restrict
        constraint delivery_shop_id_check
            check (shop_id  0),
    supplier_id       integer not null
        constraint delivery_supplier_suplier_id_fk
            references supplier
            on update cascade on delete restrict
        constraint delivery_supplier_id_check
            check (supplier_id  0),
    delivery_number   serial
        constraint delivery_pk
            primary key
        constraint delivery_delivery_number_check
            check (delivery_number  0),
    datetime_delivery date,
    delivery_price    money
        constraint delivery_delivery_price_check
            check (delivery_price = money(0))
);

alter table delivery
    owner to postgres;

