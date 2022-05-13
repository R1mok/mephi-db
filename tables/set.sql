create table set
(
    set_id serial
        constraint set_pk
            primary key
        constraint set_set_id_check
            check (set_id > 0),
    price  money
        constraint set_price_check
            check (price >= money(0))
);

alter table set
    owner to postgres;

