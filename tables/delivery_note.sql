create table delivery_note
(
    delivery_note_id      serial
        constraint delivery_note_pk
            primary key
        constraint delivery_note_delivery_note_id_check
            check (delivery_note_id > 0),
    courier_id            integer not null
        constraint delivery_note_courier_courier_id_fk
            references courier
            on update cascade on delete restrict
        constraint delivery_note_courier_id_check
            check (courier_id > 0),
    shop_id               integer
        constraint delivery_note_shop_shop_id_fk
            references shop
            on update cascade on delete restrict
        constraint delivery_note_shop_id_check
            check (shop_id > 0),
    description           varchar(500),
    order_time            date,
    delivery_time_planned time,
    delivery_time_real    time,
    customer_signature    boolean
);

alter table delivery_note
    owner to postgres;

