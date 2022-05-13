create table set_in_order
(
    order_id          integer not null
        constraint set_in_order_customer_order_order_id_fk
            references customer_order
            on update cascade on delete restrict
        constraint set_in_order_order_id_check
            check (order_id > 0),
    set_id            integer not null
        constraint set_in_order_set_set_id_fk
            references set
            on update cascade on delete restrict
        constraint set_in_order_set_id_check
            check (set_id > 0),
    quantity_in_order integer
        constraint set_in_order_quantity_in_order_check
            check (quantity_in_order >= 0),
    constraint set_in_order_pk
        primary key (order_id, set_id)
);

alter table set_in_order
    owner to postgres;

