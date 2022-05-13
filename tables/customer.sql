create table customer
(
    customer_id serial
        constraint customer_pk
            primary key
        constraint customer_customer_id_check
            check (customer_id > 0),
    name        varchar(50) not null
        constraint customer_name_check
            check ((name)::text ~ similar_to_escape('[А-ЯA-Z][а-яa-z]{1,49}'::text)),
    surname     varchar(50) not null,
    email       varchar(50),
    phone       varchar(15)
        constraint customer_phone_check
            check ((phone)::text ~ similar_to_escape('([8][0-9]*)|([+][7][0-9]*)'::text))
);

alter table customer
    owner to postgres;

create unique index customer_email_uindex
    on customer (email);

create unique index customer_phone_uindex
    on customer (phone);
