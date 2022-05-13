create table customer_order
(
    order_id         serial
        constraint customers_order_pk
            primary key
        constraint customer_order_order_id_check
            check (order_id > 0),
    delivery_note_id integer
        constraint customer_order_delivery_note_delivery_note_id_fk
            references delivery_note
            on update cascade on delete restrict,
    customer_id      integer
        constraint customers_order_customer_customer_id_fk
            references customer
            on update cascade on delete restrict
        constraint customer_order_customer_id_check
            check (customer_id > 0),
    receipt          integer
        constraint customer_order_receipt_receipt_id_fk
            references receipt
            on update cascade on delete restrict
);

alter table customer_order
    owner to postgres;

