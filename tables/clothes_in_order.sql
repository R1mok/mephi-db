create table clothes_in_order
(
    clothes_id        integer not null
        constraint clothes_in_order_clothes_clothes_id_fk
            references clothes
            on update cascade on delete restrict
        constraint clothes_in_order_clothes_id_check
            check (clothes_id > 0),
    order_id          integer not null
        constraint clothes_in_order_customer_order_order_id_fk
            references customer_order
            on update cascade on delete restrict
        constraint clothes_in_order_order_id_check
            check (order_id > 0),
    quantity_in_order integer
        constraint clothes_in_order_quantity_in_order_check
            check (quantity_in_order >= 0),
    constraint clothes_in_order_pk
        primary key (clothes_id, order_id)
);

alter table clothes_in_order
    owner to postgres;