create table salary
(
    salary_id         serial
        constraint salary_pk
            primary key
        constraint salary_salary_id_check
            check (salary_id > 0),
    shop_assistant_id integer
        constraint salary_shop_assistant_shop_assistant_id_fk
            references shop_assistant
            on update cascade on delete restrict
        constraint salary_shop_assistant_id_check
            check (shop_assistant_id > 0),
    courier_id        integer
        constraint salary_courier_courier_id_fk
            references courier
            on update cascade on delete restrict
        constraint salary_courier_id_check
            check (courier_id > 0),
    sold_quantity     integer
        constraint salary_sold_quantity_check
            check (sold_quantity >= 0)
);

alter table salary
    owner to postgres;

