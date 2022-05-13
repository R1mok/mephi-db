create table receipt
(
    receipt_id             serial
        constraint receipt_pk
            primary key
        constraint receipt_receipt_id_check
            check (receipt_id > 0),
    shop_assistant_id      integer not null
        constraint receipt_shop_assistant_shop_assistant_id_fk
            references shop_assistant
            on update cascade on delete restrict
        constraint receipt_shop_assistant_id_check
            check (shop_assistant_id > 0),
    shopping_date_and_time timestamp
);

alter table receipt
    owner to postgres;
