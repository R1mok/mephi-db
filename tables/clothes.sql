create table clothes
(
    clothes_id serial
        constraint clothes_pk
            primary key
        constraint clothes_clothes_id_check
            check (clothes_id > 0),
    name       varchar(100)
        constraint clothes_name_check
            check ((name)::text ~ similar_to_escape('[A-ZА-Я][a-zа-я ]{1,99}'::text)),
    type       varchar(100)
        constraint clothes_type_check
            check ((type)::text ~ similar_to_escape('[A-ZА-Я][a-zа-я ]{1,99}'::text)),
    color      varchar(25),
    size       clothes_size,
    price      money
        constraint clothes_price_check
            check (price > money(0))
);

alter table clothes
    owner to postgres;